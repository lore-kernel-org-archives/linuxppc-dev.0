Date: Thu, 13 Sep 2001 16:32:55 -0400
Message-Id: <200109132032.f8DKWtC31647@hyper.wm.sps.mot.com>
From: Peter Barada <pbarada@mail.wm.sps.mot.com>
To: dan@mvista.com
Cc: mlocke@mvista.com, cdonovan@lanier.com,
	linuxppc-embedded@lists.linuxppc.org
In-reply-to: <3BA1149F.65E7B1C1@mvista.com> (message from Dan Malek on Thu, 13
	Sep 2001 16:18:39 -0400)
Subject: Re: Status on 403 (Oak) support
References: <C97ABDA0DC2DD511BA400002A50974132804F1@jdry.lanier.com> <3BA0FA9E.5010204@mvista.com> <200109131951.f8DJpN228832@hyper.wm.sps.mot.com> <3BA1149F.65E7B1C1@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>> To figure this out we need to know which instructions the assembler
>> was trying to assemble.
>
>To me, it's very clear :-).  It was trying to use SPRG4-7 that
>don't exist on the 403.....

Uh, yeah, that's crystal clear :-)

The point I tried to make is that assembler errors like that are
impossible to figure out without having the context that caused
it(command line, assembler instructions, stabn numbers, etc).

--
Peter Barada                                   Peter.Barada@motorola.com
Wizard                                         781-852-2768 (direct)
WaveMark Solutions(wholly owned by Motorola)   781-270-0193 (fax)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
