From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14250.59442.119941.343153@gargle.gargle.HOWL>
Date: Fri, 6 Aug 1999 09:50:42 -0400 (EDT)
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: How DOES OF Work? (ie multi-OS woes)
In-Reply-To: <199908052138.RAA29909@mail-1.global2000.net>
References: <199908052138.RAA29909@mail-1.global2000.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> "Andrew" == Andrew B Arthur <arthur99@global2000.net> writes:

 >> I wish you good luck... Maybe you could come up w/ a way to boot from a
 >> selection of OS'es via OF. But the mac crowd will still wine, as there is
 >> no icons to click on in OF... =/

 Andrew> See http://www.linuxppc.org/userguide/bootMenu.html for the Open
 Andrew> Firmware boot menu.

 Andrew> It always used to work quite well, so I expect it would work good
 Andrew> now.

 Andrew> Supports timeout (after 180 seconds), and presents you with a boot
 Andrew> list like this:

 Andrew> <m>ac os <l>inux-pmac <o>pen firmware

Don't forget, this won't be that useful on 7200-class machines, i.e. you can't
see the screen.  At least assuming that you have someone who isn't a computer
geek who wants to use the machine.

Is there any hope of doing something about the broken OF on these machines?  I 
don't expect that there is, but I can always hope.  The only things I really
see as possible are some kind of boot loader that can kick in at the point
when macOS would normally be loaded from disk or somehow being able to create
new ROMS with correct OF in them.

Thanks,

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
