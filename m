Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <kevin.hendricks@sympatico.ca>
To: Michel =?iso-8859-1?q?D=E4nzer?= <michel@daenzer.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Weird interrupt problem
Date: Wed, 7 Aug 2002 20:28:01 -0400
References: <1028761518.1262.1236.camel@tibook>
In-Reply-To: <1028761518.1262.1236.camel@tibook>
MIME-Version: 1.0
Message-Id: <200208072028.01216.kevin.hendricks@sympatico.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Twice now I have seen something that may be related.  The whole system
becomes very sluggish with either one or both cpus consuming 99% of
capacity while receiving funny interrupt messages.

I literally had to shutdown the system which took forever (I had to keep
hitting <return> to allow the second cpu to have a chance at things).

This is with an almost stock ben 2.4.19-pre10 kernel compiled for SMP on a
Dual G4 1-gig machine.  I have never seen anything in the message logs
that provides a good hint at why this is happening.

Again it has only happended twice now but it is very annoying (the system
becomes so sluggish you almost think it has hung completely).

I have no idea if this is related but it may be.

Kevin

On August 7, 2002 07:05, Michel Dänzer wrote:
> Today this happened to me the second time: All of a sudden, the USB
> mouse stopped working. At the same time this appeared in the syslog:
>
> Aug  7 17:19:57 tibook kernel: Unhandled interrupt 1d, disabled
>
> Plugging the mouse to the other socket worked, but it wouldn't work
> again in the original one. As you can see in the attached
> /proc/interrupts, interrupt 29 (=1d) is unknown. Interestingly,
> interrupt 28 seems to be for the USB socket which stopped working (I
> think it was the same one when the first problem first occured, might be
> coincidence though). Was it somehow rewarded for its 100'000th
> occurence? ;) Seriously, is it possible that the number changed somehow?
>
>
> This wouldn't be all that bad, if the whole system wasn't very sluggish
> afterwards. When it occured the first time, I had CONFIG_TAU enabled in
> the kernel, which Ben said might cause the sluggishness at least. But
> now it's disabled.
>
>
> This is on a TiBook III/667 running 2.4.18-ben0-lotsanicestuff if it
> matters. The first occurence was with 2.4.19-presomething-ben0.
>
>
> Has anyone experienced anything similar?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
