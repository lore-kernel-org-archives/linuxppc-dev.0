Message-ID: <3AF0706B.AB26C573@mvista.com>
Date: Wed, 02 May 2001 13:39:07 -0700
From: Matthew Locke <mlocke@mvista.com>
MIME-Version: 1.0
To: Steven Hein <ssh@sgi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mkcramfs changes to switch endianness
References: <3AF07046.3827B997@sgi.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


cramfs is still endian dependant.  Linus has a couple solutions to this
problem, but last time I checked he wasn't clear which was the best.  go
for it and let us know how it turns out.

Steven Hein wrote:
>
> I'm getting ready to try using cramfs in the 2.4.4 kernel.
> Anybody done the work to make 'mkcramfs' create a big-endian
> image on a little-endian PC?   Before I reinvent the wheel,
> I'd like to find out if anybody as done it (and would like
> to share   :)
>
> Steve
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
