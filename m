Date: Thu, 13 Jan 2000 02:55:57 -0800 (PST)
From: "Keith W. Shaw" <keithws@fork.yi.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Open firmware booting & atyfb
Message-ID: <Pine.NEB.4.21.0001130230090.569-100000@dizzy>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hi.  i'm running linux 2.2.14 on a pb g3 (wallstreet) 300mhz.  i was
booting everything just fine from bootx, but no longer need the macos and
have been trying to find other methods of booting.

i've succeded in getting it to netboot and also to boot off the internal
hard drive !!!

problem now is that it doesn't like the kernel arguements i'm passing it
to set the video to atyfb (i get the infamous 'melting' screen).  the only
way to get it to work is to not include atyfb support in the kernel.  then
it boots fine, but obvisiously i can't get into x (i like to use
XF86_fbdev for glx devel, so i don't like xpmac).

i've also tried passing various kernel arguements.  my normal
(bootx) arguement is "video=atyfb:vmode:14,cmode:32"  it appears that it's
trying to change, but just can't (by the way try vmode:13 for something
interesting :)

any body have any ideas???

	keith.

http://fork.yi.org/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
