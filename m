Message-Id: <v04003a02b47493b8bdac@[216.81.20.25]>
In-Reply-To: 
 <Pine.LNX.3.96LJ1.1b7.991208154524.1742A-100000@ofey.inetnebr.com>
References: <199912081427.IAA30654@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 8 Dec 1999 18:24:22 -0600
To: linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <eek@escape.ca>
Subject: Non-OF Ports (was Re: Need developer to help move JDK ppc port
 forward)
Cc: Benjamin Herrenschmidt <bh40@calva.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:12 PM -0600 12/8/99, Takashi Oe wrote:
>On Wed, 8 Dec 1999, Kevin_Hendricks wrote:
>[...I'm sorry to hear about JDK port...]
>> Also, if anyone needs a 40 something year old former PDP-8 and PDP-11
>>programmer
>> with time on his hands to help out a *true* Open Source project, let me
>>know...
>
>Do you still have 8100 with you?  If so, porting Linux/PPC to your machine
>may be a project for you.  Now that BootX can boot MkLinux, everything
>there is open source (finally).

Speaking of Non-OF machines...

I was thinking it would help porting (in my case, to my 5200, which I
unfortunatley haven't had much chance to work on lately) if BootX were able
to construct a fake OF device tree in the absence of a real one.

I'm not sure exactly what the structure should be, but the kernel shoudn't
need a whole bunch information as the NuBus style hardware is fairly simple.


I'd do it myself, but I don't have codewarrior. (Fooey on non-free MacOS
dev tools) :)


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
