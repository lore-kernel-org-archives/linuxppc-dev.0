Message-ID: <20010918212029.5151.qmail@web11006.mail.yahoo.com>
Date: Tue, 18 Sep 2001 14:20:29 -0700 (PDT)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: planb errors
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


	This is what I meant when I said I can't record any frames or video on my
Power Mac 8500 via the planb AV driver via the Video4Linux API.  'streamer' is
the basic recorder app in the xawtv distro, and these commands are based on
examples from its man page.  I downloaded the xawtv 3.61 .tar.gz file and did
'rpm -ta' on it for the resulting apps.
	I started up v4l and planb like so:

sudo /sbin/modprobe videodev
sudo /sbin/insmod planb def_norm=1

	The "def_norm=1" ensures that it's in NTSC mode.  Passive viewing with 'fbtv'
works just fine.
	This is what happens when I try to get a frame, wait a while, and finally hit
ctrl-c.

[dtm@Lucas dtm]$ streamer -o zelda.jpeg
files / video: JPEG (JFIF) / audio: none
ioctl: VIDIOCSCHAN(0,Composite,flags=0x0,type=2,norm=3): Invalid argument
mmap: No buffer space available
^C - one moment please
^C - one moment please
^C - one moment please
[dtm@Lucas dtm]$ dio 0/0, video 0/16, convert 0/0

	This is an attempt to record a movie.

[dtm@Lucas dtm]$ streamer -o quicktime.mov -f yuv2 -F stereo -r 12 -t 120
neither audio nor video format specified/found
[dtm@Lucas dtm]$

	Any input?  Hehehe, that's a pun.


=====
Medium System Administrator and Junior I.T. Manager of 5 yrs
 -- Now available -- Linux, MacOS, Unix-like systems
    -- http://mmmgood.net -- dan_bethe@yahoo.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
