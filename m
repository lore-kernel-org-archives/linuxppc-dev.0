Date: Sat, 12 May 2001 14:51:00 -0700
From: Ira Weiny <iweiny@acm.org>
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Message-id: <3AFDB044.85BDB846@acm.org>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <3AFD9868.29C558@folkwang-hochschule.de>
 <20010512203422.23549@smtp.wanadoo.fr>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> >* every 10 or so sleep cycles, the machine locks up. blank screen,
> >no standby-led, and i can only power off with ctrl-alt-apple-power.
> >sysrq fails, too.
>
> It locks up on wakeup or on sleep ?
>

Just for the record, my Titanium did this the other day as well.  I woke
it up.  I got a screen.  It blanked (the video driver was driving the
screen but displaying all black.) and that was it...  It happened out of
the blue, not before or since.

I could not try to telnet into the box, no other machine.  So I don't
know if it was really down or not.  This is with a recent (< 1week) Ben's
tree and no logs pertaining to anything wrong?

Anyway,  I have not been counting my sleep cycles so I will try what the
gentelman above said to see if I can reproduce it.  But I don't think
I can since I rarely shutdown the machine, just make it sleep.

Anyway thanks because this is working great 99.999% of the time...  ;-)

Ira


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
