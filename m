Message-ID: <3A956EF9.E532F518@mvista.com>
Date: Thu, 22 Feb 2001 11:56:41 -0800
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Subodh Nijsure <subodh@best.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Status of linux-ppc kernel.
References: <200102221739.JAA03312@shell9.ba.best.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure wrote:
>

> Also there seem to be few patches like Wolfgang's ethernet patch
> found on ftp.denx.de or m8xx_pcmcia stuff that hasn't shown up in
> 2.4.X latest kernel.  Are these things going to get merged into
> "mainline" sometime and does anybody know probable dates etc.?

m8xx_pcmcia is a part of the pcmcia-cs tree.  The kernel changes depend
on where you ioremap memory for pcmcia, which is board dependent.  I
need to send Dan a kernel patch for the EP boards, but I haven't done it
yet:(

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
