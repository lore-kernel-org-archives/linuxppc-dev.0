From: "James Brown" <jbrown@qmm.com.au>
To: <mlan@cpu.lu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: RE: planb in BK tree..
Date: Wed, 24 Jan 2001 14:49:50 +0800
Message-ID: <000001c085d1$da042e20$a100a8c0@james>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <200101231925.UAA00899@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi there,
>
>Sorry for replying late, but I'm still wading through a 400-message
>backlog...

Yes, I know the feeling well :)

>> Any chance of getting the planb driver in the current 2_4 bitkeeper tree
>> patched with the 2.4 fix for it? :)
>I'll get back to work on PlanB somewhere in late February, hopefully.
>Feel free to post a working diff, if you have one. Where did you get the
>original patches from?

Basically I manually applied the
http://www.cpu.lu/~mlan/ftp/planb-2.4.0-t6-patch patch against the current
BK tree at the time. That seemed to fix the issues I was having with 2.4.0
crashing on boot (couldn't find the PlanB device, but was giving me the
previous, cryptic, error message).

I can probably whip up a diff later, but that'd involve me finding some
spare time of my own *grin*.

> I spent most of last night manually patching the thing (for some reason a
> few chunks failed, and I had nothing else to do) - After applying that my
> whole setup works great, except for a few things I think are caused by
> package version messups.

What version messups would that be?

Turned out to be a few endian issues with other drivers (consolefb doesn't
like having VGA Console turned on).

>Michel
>-------------------------------------------------------------------------
>Michel Lanners                 |  " Read Philosophy.  Study Art.
>23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
>L-1710 Luxembourg              |
>email   mlan@cpu.lu            |
>http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
