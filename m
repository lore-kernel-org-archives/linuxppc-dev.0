Message-ID: <3967760D.C323D75F@erols.com>
Date: Sat, 08 Jul 2000 14:42:21 -0400
From: Nelson Abramson <pogtal@erols.com>
MIME-Version: 1.0
To: Robert Thompson <rothomp3@vt.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: trackpad and 2.2.17prex-ben1
References: <4.3.2.7.2.20000707230217.00c1e280@mail.munich.netsurf.de> <00070807530600.08702@rothomp3>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Robert Thompson wrote:

> <snip>
> Hmmm... well, I have all those options enabled, but it didn't help any. dmesg
> shows that the trackpad is found and initialized, etc, but it just doesn't
> work! Xpmac doesn't use it, and I tried numerous gpm lines trying to get it to
> work, to no avail. dmesg reports that it's mouse3, so I even tried
> gpm -m /dev/input/mouse3 -t imps2: results in no function
> gpm -m /dev/input/mouse3 -t bm: results in no function
> gpm -m /dev/mouse -t imps2: external USB trackball works great, but still no
> trackpad

<snip>
Assuming that you have not changed gpm's defaults, and that you have linked both
/dev/input/mouse and /dev/input/usbmouse to /dev/mouse, all you should need to do
is "gpm -t imps2", and that should allow gpm to take input from both your external
usb mouse and the trackpad.  If you have X use /dev/mouse, then it should also
beable to take input from both sources (it works for my Pismo).

HTH
--Nelson Abramson


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
