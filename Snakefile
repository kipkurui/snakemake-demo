SAMPLES = ['Sample1', 'Sample2']

rule all:
    input:
        'test.txt'

rule quantify_genes:
    input:
        genome = 'genome.fa',
        r1 = 'fastq/{sample}.R1.fastq.gz',
        r2 = 'fastq/{sample}.R2.fastq.gz'
    output:
        '{sample}.txt'
    shell:
        'echo {input.genome} {input.r1} {input.r2} > {output}'

rule collate_outputs:
    input:
        expand('{sample}.txt', sample=SAMPLES)
    output:
        'test.txt'
    run:
        with open(output[0], 'w') as out:
            for i in input:
                sample = i.split('.')[0]
                for line in open(i):
                    out.write(sample + ' ' + line)