Date: Thu, 15 Jul 1999 12:35:03 -0500 (CDT)
From: Dave Weis <djweis@plconline.com>
To: "David A. Gatwood" <dgatwood@mvista.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: performa 6214 support?
In-Reply-To: <Pine.LNX.3.96.990715103205.6283H-100000@mvista.com>
Message-ID: <Pine.LNX.4.10.9907151233580.25231-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On Thu, 15 Jul 1999, David A. Gatwood wrote:
> On Thu, 15 Jul 1999, Dave Weis wrote:
> > so it would require using more of the mac-68k stuff? if i had time, should
> > i start with the mklinux stuff? would i have to modify the mach kernel or
> > just the linux kernel?
> Mach Kernel.  I've gotten most of the interrupt handling support in place,
> I _think_, and most of the devices know about their locations in the
> Performas.  I just no longer have a machine nearby for testing.  Also,
> some machines in that class don't get past the splash screen, and I have
> no idea why.  Probably something in the early memory mapping stuff or
> something similar.  Dunno.  I'm thinking that maybe it might be dependent
> on how much RAM the machine has, but I had no way to test that hypothesis.

do you have a pointer to where i could find this? i have one at home now
to prod and a 7300 here that i can use to compile (or bite the bullet and
get the cross compiler downloaded).


dave


-- 
David Weis                | 10520 New York Ave, Des Moines, IA 50322
djweis@plconline.com      | Voice 515-278-0133 Ext 231

When they took the Fourth Amendment, I was quiet because I didn't deal drugs.
When they took the Sixth Amendment, I was quiet because I was innocent.
When they took the Second Amendment, I was quiet because I didn't own a gun.
Now they've taken the First Amendment and I can't say anything.


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
