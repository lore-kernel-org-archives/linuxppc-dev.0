From: Benjamin Herrenschmidt <bh40@calva.net>
To: <paulus@linuxcare.com.au>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Patches for 2.4.0-test7
Date: Sun, 27 Aug 2000 14:02:02 +0200
Message-Id: <20000827120202.24878@192.168.1.10>
In-Reply-To: <14760.58981.931858.747899@argo.linuxcare.com.au>
References: <14760.58981.931858.747899@argo.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Found this one. :-)  Thanks for alerting me to it.  This was because I
>have some mods in my tree to add extra aux table entries for the ppc
>cache line size.  I was using the numbers assigned in the Sys V ABI
>but these conflict with numbers assigned to other things by linux.
>The end result was that ld.so always thought it was loading a setuid
>program and therefore disabled LD_LIBRARY_PATH.  It's now fixed in my
>rsync tree.

BTW. The cset I sent you contains code from Dan Malek that implements an
elegant solution to the CPU detection stuff by emulating the "mfspr"
instruction when issued from userland. We can also (not done yet)
masquerade the CPU (by letting it think it's a G3 and not a G4 when
altivec is not enabled in the kernel for example).


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
