Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <3A0C3B44.A623BCF8@arlut.utexas.edu>
Date: Fri, 10 Nov 2000 12:15:32 -0600
From: Matt Karger <karger@arlut.utexas.edu>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: AltiVec bug in Linux SMP kernel (2.2.18)?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am currently benchmarking FFTs on our SMP box (Synergy VSS4 G4 400 MHz

- Linux 2.2.18)  using two different libraries.  One is FFTW, and the
other is an
AltiVec-enabled library I downloaded from the Apple Developer's
website.  Both
libraries run as expected on a PowerMac G4 running Linux 2.2.17.  Both
libraries
run as expected on the SMP machine using the uniprocessor kernel .  The
FFTW
library runs as expected on the SMP machine using the SMP kernel.
However,
when I use the AltiVec FFT library on the VSS4 with the SMP kernel, the
results
are corrupted.  Is there still an AltiVec bug in the SMP kernel?


Thanks in advance,

Matthew Karger
Sr. Student Associate
Applied Research Laboratory
The University of Texas at Austin
karger@arlut.utexas.edu


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
