Message-Id: <v04003a00b31599a44c21@[204.22.210.180]>
In-Reply-To: <19990317162518.010351@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 17 Mar 1999 17:50:32 +0000
To: Benjamin Herrenschmidt <bh40@calva.net>
From: "sean o'malley" <somalley@ed.mde.state.mi.us>
Subject: Re: Apple Open Source: the drivers
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>There's a PMU driver with apparently up-to-date command length tables and
>lots of comments about the commands ;-) An interesting thing that I've
>not seen in the LinuxPPC driver: When sending read commands to
>non-existing devices, the PMU may never answer, and so there's need for
>some kind of timeout. I didn't find infos about putting the PowerBook to
>sleep, maybe MacOS X Server cannot sleep...

Hey maybe we will get the b/w g-3's (yMacs) running yet..

Macos X Server doesnt have any sleep code.. it wasnt written for that..
you also wont see _much_ USB (keyboard and mouse) support and it is still
lacking Firewire support from everything i have read.

Powerbooks arent supported at all..
Which makes me wonder why... Apple was giving major discounts to developers
on those things. unless they just wanted to give out information and
support linuxppc..





[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
