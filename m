Message-ID: <39EECA3F.E57F2290@pop.agri.ch>
Date: Thu, 19 Oct 2000 12:18:00 +0200
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: Henning Loeser <Henning.Loeser@Physik.Uni-Marburg.DE>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: ADB-Mouse
References: <Pine.OSF.4.02.10010190958400.3355-100000@ax1305.physik.uni-marburg.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Henning Loeser wrote:

> I do have /proc/device-tree/bandit/gc/via-cuda/adb/mouse/device_type
> .../name and .../reg so I would think the mouse should be there, ...
> shouldn't it?
> Do I have to create a new /dev/adbmouse entry ? It works with 2.4.0-t2 ...

No, see Ben's site for more info, the new layer is also integrated in
2.4 now.

http://ppclinux.apple.com/~benh/

/dev/adbmouse "changed" to /dev/input/mice


Andreas

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
