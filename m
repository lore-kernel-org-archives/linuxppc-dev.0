From: Ruedi.Hofer@ascom.ch
Date: Thu, 28 Sep 2000 08:51:27 +0100 (CED)
Subject: Re: Re: VxWorks bootloader & PowerQUICC II, Booting the kernel
To: dan@mvista.com, linuxppc-embedded@lists.linuxppc.org
Cc: kernel@linux01.hasler.ascom.ch
Message-id: <0G1L0010X4GL0O@pmdf-it.hasler.ascom.ch>
MIME-version: 1.0
Content-type: MULTIPART/MIXED; BOUNDARY="Boundary_(ID_iPTVGucqr+vB7AqeeyJXVQ)"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--Boundary_(ID_iPTVGucqr+vB7AqeeyJXVQ)
Content-type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT

Hi Dan

I guess I found the message which points to the tool mentioned in your
answer below:

>I wrote a program that will hack the headers such that the stupid
>VxWorks TFTP loader would load the zImage (like other properly
>written loaders will do without any hacks).  I don't know if this
>will help anyone else.  You can find it on
>       ftp://ftp.embeddededge.com/pub/vxhack.c
>
>
>       -- Dan

Unfortunately, this link doesn't work anymore! Do you mind sending
a copy of this file directly to me?

Thank you, Ruedi






dan@mvista.com on 27.09.2000 19:36:24
An: Ruedi.Hofer@ascom.ch @ MailGate
Kopie: linuxppc-embedded@lists.linuxppc.org @ MailGate, vanbaren_gerald@si.com @ MailGate, kernel@linux01.hasler.ascom.ch @ MailGate
Thema: Re: VxWorks bootloader & PowerQUICC II, Booting the kernel


Ruedi.Hofer@ascom.ch wrote:

> I try to boot the Linux kernel on a SBC8260 evaluation board using
> the VxWorks bootloader.

Somewhere (and you can look through the archives as well as I can :-),
I posted a program that will hack a zImage so the VxWorks boot loader
will properly load and start it.....





--Boundary_(ID_iPTVGucqr+vB7AqeeyJXVQ)--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
