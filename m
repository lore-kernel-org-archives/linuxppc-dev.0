MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: microcodepatch
Date: Thu, 25 Oct 2001 09:27:00 -0000
Message-ID: <EADB10BAC266A14A85ECBF8686A73E31459354@kolkrabbi.flaga.is>
From: =?iso-8859-1?B?S+FyaSBEYXbt8HNzb24=?= <kd@flaga.is>
To: "Dan Malek" <dan@mvista.com>
Cc: "Linux Embedded ppc (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

Indeed the microcode patch seemd to be different, but even though I use
the
I2C 823 patch downloaded from the mot.com site. Everything behaves the
same
untill I compile the I2C support code into the kernel then the network
does
not crash the kernel.

K.D.

> -----Original Message-----
> From: Dan Malek [mailto:dan@mvista.com]
> Sent: 24. október 2001 19:38
> To: Kári Davíðsson
> Cc: Linux Embedded ppc (E-mail)
> Subject: Re: microcodepatch
>
>
> Kári Davíðsson wrote:
>
> > Are there any known issues regarding the I2C patch and the ethernet
> > driver?
>
> You need to ensure the patch is suitable for the CPM on the processor
> you have.  I know the USB SOF patch works on the 823/850 Rev.
> B processors,
> but I don't remember where the others came from.  You should probably
> visit Motorola's web site and get the patch specific to your processor
> and update the microcode patch file.
>
> > If I disable the microcode patch everything works fine,
> except the I2C
> > stuff.
>
> Depending upon the application, sometimes it is easier and faster to
> simply use the software toggle agorithm on the pins rather than the
> CPM controller.
>
>
> 	-- Dan
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
