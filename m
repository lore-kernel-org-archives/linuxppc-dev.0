Message-ID: <3DD126B4.61740F57@imc-berlin.de>
Date: Tue, 12 Nov 2002 17:05:08 +0100
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Stephan Linke <Stephan.Linke@epygi.de>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	s.coluccini@caen.it
Subject: Re: Using ioctl from with the kernel ???
References: <FCEAKDJJAPHPLJFINDAJKEAECLAA.Stephan.Linke@epygi.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephan Linke wrote:
>
> Hi Steve,
>
> If you realy like to do so you can call the LEDDRIVER_ioctl() function
> directly with some dummy parameter (the one of you LED driver, not the one
> from user space wich is to be called using an file descriptor). But I would
> prefer to move the functionality into some extra function and call these
> function from LEDDRIVER_ioctl() and from OTHERDRIVER_change_led() (like
> Stefano suggested).

Many thanks to you both.

I'll try that!

Good luck,

Steven

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
