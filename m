From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ira Weiny <iweiny@acm.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pismo sleep behaviour w/ 2.4.4-benh
Date: Sun, 13 May 2001 12:04:41 +0200
Message-Id: <20010513100441.4401@smtp.wanadoo.fr>
In-Reply-To: <3AFDB044.85BDB846@acm.org>
References: <3AFDB044.85BDB846@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Just for the record, my Titanium did this the other day as well.  I woke
>it up.  I got a screen.  It blanked (the video driver was driving the
>screen but displaying all black.) and that was it...  It happened out of
>the blue, not before or since.

If that happens, I'd appreciate to have some details about these:

 - Were you in console mode or in X when you put it to sleep ? (There
are still some known issues with sleep & console mode)

 - When you woke it up, did you see the screen and then see it blank
or did it come up already blanked ? Did you see the sleep LED flash
briefly 3 times as it normally does on wakeup or did the machine hang
before that ?

 - If you are "blanked", only keyboard or trackpad will get you out
of it. However, as you may have noticed, ADB probe is done asynchronously
on these machines. That means that the trackpad and the keyboard will only
be active after a few seconds. Well, I guess you did wait long enough
before deciding it was dead, but well... the next time, if you have an
USB keyboard or mouse at hand, try plugging it in and see if you get
it out of "blank" this way. Basically, I need to know if the machine actually
died or if it's the ADB part that did not come back up.

>I could not try to telnet into the box, no other machine.  So I don't
>know if it was really down or not.  This is with a recent (< 1week) Ben's
>tree and no logs pertaining to anything wrong?
>
>Anyway,  I have not been counting my sleep cycles so I will try what the
>gentelman above said to see if I can reproduce it.  But I don't think
>I can since I rarely shutdown the machine, just make it sleep.
>
>Anyway thanks because this is working great 99.999% of the time...  ;-)


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
