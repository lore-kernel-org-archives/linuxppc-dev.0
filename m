Content-Type: text/plain;
  charset="us-ascii"
From: Alban Fellows <Alban.Fellows@blueyonder.co.uk>
To: linuxppc-dev@lists.linuxppc.org,
	Yellowdog General <yellowdog-general@lists.terrasoftsolutions.com>
Subject: USBHID Problem
Date: Thu, 7 Nov 2002 22:01:12 +0000
MIME-Version: 1.0
Message-Id: <200211072155.39017.Alban.Fellows@blueyonder.co.uk>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am having problems with the BK kernel from a version somewhat after
2.4.20-pre7 upto 2.4.20-rc1

2.4.20-pre7 works fine
later kernels seem to hang on the USB stuff
by selectively disabling USB stuff, I can get the machine to boot properly
only if I remove the USBHID (Full) support
The basic keyboard and mouse work (with side effects)
I prior to this had not changed any kernel config (I reularly fetch and build
the latest kernel - one of these days full nVidia support will be available)

The machine is a Apple Macintosh G4 (DVD) running YDL 2.3
USB is the OHCI driver

As this appears quite a major loss of functionality I am surprised that
several kernel versions appear to suffer the problem.

Anybody have similar problems or fixes?

Alban


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
