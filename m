Message-Id: <199909100518.WAA05129@soda.CSUA.Berkeley.EDU>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: note about compiling SMP kernels 
In-Reply-To: Your message of "Fri, 10 Sep 1999 14:14:20 +1000."
             <199909100414.OAA07651@tango.anu.edu.au>
Date: Thu, 09 Sep 1999 22:18:09 -0700
From: Sriranga Veeraraghavan <ranga@CSUA.Berkeley.EDU>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> So, before compiling for SMP for the first time, do a make clean in
> the tree first, even if the tree has no object files in it.

Is the correct procedure still:

cd /usr/src/linux
make mrproper
make pmac_config
make menuconfig (or whatever you please)
make dep
make clean
gmake -j 3 vmlinux 

Just as a side note: I recently upgraded to LinuxPPC R5 and was able
to sucessfully compile a SMP 2.2.12 kernel from stock sources from
ftp.kernel.org.

I have since determined that my problems with LinuxPPC R4.1 were due
to an older version of gcc/egcs. The stock gcc in R4.1 is egcs 1.02,
but it looks like I needed egcs 1.1.2 to sucessfully build a SMP
kernel.

----ranga <ranga@soda.berkeley.edu>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
