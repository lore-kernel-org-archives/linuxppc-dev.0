Date: Tue, 24 Aug 1999 08:29:01 -0500 (CDT)
From: Dave Weis <djweis@plconline.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: Tony Mantler <eek@escape.ca>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Performa 5200
In-Reply-To: <19990824110602.000653@mail.mipsys.com>
Message-ID: <Pine.LNX.4.10.9908240826490.24794-100000@catbert.desm.plconline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> >I'm not particularily fluent in PPC ASM, so head.S makes fairly opaque
> >reading for me. I'm wondering if someone might have some pointers to where
> >this would likely be dying, so I have good a place to start?
> 
> is this a NuBus class machine or a PCI based one ? If it's a NuBus one,
> then you are out of luck, or if you have time to spend, you can begin
> porting linux/ppc to those beasts. (Basically, RAM is not contiguous and
> you cannot rely in the kernel beeing loaded at physical 0, since the
> frame buffer may be hard coded at physical 1Mb). Look at the various
> parameters BootX pass for a NuBus machine (using the latest 2.1.12 kernel
> from vger or Paul's rsync, you should have the latest bootx.h).

Depending on how in to the 68k boxes you are, the impression I got is that
the memory structure is very similar to the 68ks of the same shape/era. I
tried it on my wife's 6114CD and it hung with just the desktop background
visible. Mix and match some of the mac68k code and you should be done in
no time :-) haha

If you need any other machines to test a kernel on, let me know.

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
