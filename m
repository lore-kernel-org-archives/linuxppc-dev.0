Date: Tue, 9 Feb 1999 13:14:36 +0100
To: linuxppc-dev@lists.linuxppc.org,
        mklinux-development-system@public.lists.apple.com
From: BenH <bh40@calva.net>
Subject: NuBus PowerMacs and PDM video
Message-Id: <19990209131436.011982@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi !

I'm doing some experiments with the MMU (learning it's usage). The goal
is to add some better bootstrap code to BootX (get rid of the -622 error
with MacOS VM) and to add support for the rather "special" memory
mappings of the NuBus PowerMacs.

However, I have a problem with the video on those machines: If I
understand things correctly, the framebuffer is set by MacOS to physical
address 0. This is a problem for us since we need to have some exception
vectors and other things like that in this location.

I beleive MkLinux booter moves it elswhere, but I don't know how to do
that (I don't have infos about the chip and I don't have one of those
machines to test with).

Any clues ?

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
