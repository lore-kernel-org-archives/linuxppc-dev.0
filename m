Message-ID: <39A57AEC.6FA63ED5@amberdata.demon.co.uk>
Date: Thu, 24 Aug 2000 20:43:40 +0100
From: David Monro <davidm@amberdata.demon.co.uk>
MIME-Version: 1.0
To: Daniel Jacobowitz <drow@false.org>
CC: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: strange PCI resource behaviour in 2.4
References: <39A47457.EB8AC497@amberdata.demon.co.uk> <20000823212118.A18375@false.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Daniel Jacobowitz wrote:
>
> On Thu, Aug 24, 2000 at 02:03:19AM +0100, David Monro wrote:
> >
> > Hi,
> >
> > I'm seeing a strange problem with the PCI code on 2.4. What is happening
> > is that the PCI code seems to be detecting a memory region on my pcnet32
> > chip, but leaving it at 0x0:
> >
[snip]

> How recent a 2.4?  There was a bug very like this in 2.4.0test6
> affecting all architectures as far as i know.  It was resolved in the
> latest 2.4.0-test7 prepatch.
>

Problem still occurs with 2.4.0-test7-pre7 :-( I'll have to look at it
in more detail.

Cheers,

	David

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
