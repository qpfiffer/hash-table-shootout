import sys, os, subprocess, signal

programs = [
    'stl_unordered_map',
    'boost_unordered_map',
    'google_sparse_hash_map',
    'google_dense_hash_map',
    'qt_qhash',
]

# sample_interval should divide max_keys or you might miss the last observation
max_keys  = 1500*1000*1000
sample_interval = 1*1000*1000
warmup_runs = 4
obs_runs = 16

def run_throughput(outfile, run_no, prog, max_k, s_int):
    proc = subprocess.Popen(['./build_throughput/'+prog, str(max_k), str(s_int)], stdout=subprocess.PIPE)
    counter = 1
    max_counter_val = max_k/s_int
    line = None
    
    while True:
        line = proc.stdout.readline()
        if line == '':
            break
        diff = float(line.strip())
        
        if diff: # otherwise it crashed
            line = ','.join(map(str, [run_no, counter * s_int, prog, "%0.6f" % diff]))
            print >> outfile, line
            if outfile != sys.stdout:
                print line
        if counter == max_counter_val:
            break
        counter += 1
    
    os.kill(proc.pid, signal.SIGKILL)
    proc.wait()

out = open('output_throughput', 'w')

for program in programs:
    print "warmups %s" % program
    for warmup in range(warmup_runs):
        run_throughput(sys.stdout, warmup, program, max_keys, sample_interval)

    print "obs %s" % program
    for obs in range(obs_runs):
        run_throughput(out, obs, program, max_keys, sample_interval)

out.close()
