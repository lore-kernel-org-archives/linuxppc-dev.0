Date: Tue, 27 Apr 2004 15:39:08 +0200
From: Magnus Damm <damm@opensource.se>
To: Oliver Korpilla <okorpil@fh-landshut.de>
Cc: mgroeger@sysgo.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Initrd and PPCbug, can it work?
Message-Id: <20040427153908.4f1eeb8a.damm@opensource.se>
In-Reply-To: <408E55DD.7080806@fh-landshut.de>
References: <Pine.LNX.4.58.0404211503050.20798@ppcproject1>
	<20040426220944.GI19246@smtp.west.cox.net>
	<408E000A.6040303@fh-landshut.de>
	<Pine.LNX.4.56.0404270913230.2035@mag.sysgo.com>
	<408E1ED0.4050404@fh-landshut.de>
	<Pine.LNX.4.56.0404271119270.2567@mag.sysgo.com>
	<408E2AF4.2050907@fh-landshut.de>
	<Pine.LNX.4.56.0404271313190.3729@mag.sysgo.com>
	<408E55DD.7080806@fh-landshut.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 27 Apr 2004 14:45:17 +0200
Oliver Korpilla <okorpil@fh-landshut.de> wrote:

> Use the initrd loaded with the kernel as a root filesystem in memory
> after bootup.
>
> Exactly what commandline parameters for the kernel would I need to make
> that?

I don't know what magic patches that are applied to the mvl-3.1 kernel
that a customer of mine use, but we use one kernel with initrd (ext2fs)
and nfs root + ip pnp support. Then we select at boot-time how we want
to boot the system:

Development: "noinitrd ip=on nfsroot=192.168.1.1:/home/nfs/foobar"
Standalone: "ip=off"

We boot a "Gzipped Multi-File Image" from u-boot, but I guess that booting
a standard zImage from anywhere would do too.

/ magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
