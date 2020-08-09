# Loads Nonpareil library.
library(Nonpareil)

# Generating curve file.
Nonpareil.curve('MG24.npo')

# Obtain the estimated coverage.
coverage<-Nonpareil.curve('MG24.npo')
print('Estimated coverage:');
print(coverage)

# Get estimated coverage value.
print('Estimated coverage value:');
coverage$C

# Get estimated diversity value
print('Estimated diversity value:');
coverage$diversity

# Predict a coverage value given a sequencing effort value.
print('Coverage value predition given a sequencing effor value of 2e9:');
predict(coverage, 2e9)

# Generate a plot with multiple nonpareil curves from several files.npo using the function Nonpareil.curve.batch.
print('Coverage batch curves...');
samples <- read.table('/home/cabana/data/samples.txt', sep='\t', h=T);
attach(samples);
np <- Nonpareil.curve.batch(File, r=R, g=G, b=B, libnames=Name, modelOnly=TRUE);
Nonpareil.legend(np, 'bottomright');
detach(samples);

# Notifies user about result files.
print('Please check the output file RPlots.pdf')
