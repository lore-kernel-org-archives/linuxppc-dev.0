Message-Id: <200210220923.LAA07842@ipnmail.in2p3.fr>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Xavier Grave <grave@ipno.in2p3.fr>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
Date: Tue, 22 Oct 2002 11:20:58 +0200
References: <200210211341.PAA17882@ipnmail.in2p3.fr> <20021021175507.11971@192.168.4.1>
In-Reply-To: <20021021175507.11971@192.168.4.1>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Monday 21 October 2002 19:55, Benjamin Herrenschmidt wrote:
> >I've just compiled a 2.4.19 kernel with smp support but when I do a cat
> >/proc/cpuinfo I can only see one processor ? Do I need to set something
> > more than SMP=y in make config ?
> >
> >I'm using a debian kernel source package with the patches for powerpc.
>
> Newer machines need my latest tree for SMP
>
Ok, I've downloaded it and compiled it, but the only message I get at boot is
loading elf32 image or something like that and nothing more...

I have tried with vmlinux.elf-pmac, zImage.chrp, zImage.chrp-rs6k
with and without SMP.

To compile the kernel I have used a .config based on one from a 2.4.19 which
runs

Any idea ?
Thanks in advance, xavier

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
