Message-Id: <3.0.5.32.19990713084345.00807570@mailhost.bulldog.com>
Date: Tue, 13 Jul 1999 08:43:45 -0400
To: linuxppc-dev@lists.linuxppc.org
From: Joe Julicher <joe_julicher@macktrucks.com>
Subject: FB stuff from Rev 1 G3
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am trying to get 1600x1200-75 running on my G3.  The fb.modes database
does not have such an entry.  The closest being 1600x1200-76, which my
monitor complains about, or 1600x1200-66 which I complain about.  The MacOS
can do 1600x1200-75 (or so my monitor tells me) and the G3 documentation
says that is the greatest that my Rev 1 machine can do.  I CAN get this
setup with the no-video driver setting at boot.  BUT of course I want the
accel video.  How do I glean the video timing for this video mode.  Is
there a MacOS utility to measure the mode?  Is there a FB method to report
the mode when using the generic FB driver?  I tried fbset while I was in
no-driver mode, but it reported strange things that made no sense.  I
haven't yet sat down with a calculator and tweaked the 76hz & 66hz settings
into a 75hz setting.  I suppose that is what I need to do.

About my G3
Beige G3 Overclocked to 292/83/146 (CPU/BUS/CACHE)
Rage 2+ and 6mb SGRAM with AV daughter card
160 MB RAM
14GB IBM GXP drive (7200 rpm ATA-33)
LinuxPPC R5

Thanks,
Joe Julicher

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
