Message-Id: <200210221136.NAA12538@ipnmail.in2p3.fr>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Xavier Grave <grave@ipno.in2p3.fr>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: just compiled a 2.4.19 kernel with smp support...
Date: Tue, 22 Oct 2002 13:33:26 +0200
References: <200210220923.LAA07842@ipnmail.in2p3.fr> <20021022113527.12833@192.168.4.1>
In-Reply-To: <20021022113527.12833@192.168.4.1>
MIME-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tuesday 22 October 2002 13:35, Benjamin Herrenschmidt wrote:
> >Ok, I've downloaded it and compiled it, but the only message I get at boot
> > is loading elf32 image or something like that and nothing more...
> >
> >I have tried with vmlinux.elf-pmac, zImage.chrp, zImage.chrp-rs6k
> >with and without SMP.
> >
> >To compile the kernel I have used a .config based on one from a 2.4.19
> > which runs
>
> If you use linux, just boot a plain vmlinux file, not a zImage.

Work fine now, using vmlinux + the option video=ofonly.

Great to use two processors !

xavier

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
