Subject: Re: serial reset?
From: Hollis Blanchard <hollis@austin.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: embedded list <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20021106230903.GD1746@zax.zax>
References: <1036602788.17846.146.camel@granite.austin.ibm.com>
	<20021106230903.GD1746@zax.zax>
Date: 07 Nov 2002 09:49:06 -0600
Message-Id: <1036684147.31357.257.camel@granite.austin.ibm.com>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2002-11-06 at 17:09, David Gibson wrote:
>
> On Wed, Nov 06, 2002 at 11:13:08AM -0600, Hollis Blanchard wrote:
> >
> > My current problem is with the UART (and I'm using serial console only,
> > so it's problem). When I wake up, I can type commands to my shell and
> > see them echoed correctly. However the result of those commands is
> > garbled, like so:
> >   ls
> >     1  tm[lc ;u;v  43m
> > Sometimes I get the message "ttyS: 1 input overrun(s)". Return
> > characters come through as spaces.
>
> This is a wild guess, but could it be that FIFO mode hasn't been
> turned on during the restore.  That way individual characters being
> echoed (slowly) might work, but faster transfers get garbled, because
> the 405 can't keep up with the interrupts.

It looks like this was the problem. I'd tried that of course, but this
made me double-check it. :)

-Hollis

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
