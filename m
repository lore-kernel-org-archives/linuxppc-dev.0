Message-ID: <378C95F8.B89F7DD3@x8.net>
Date: Wed, 14 Jul 1999 15:51:52 +0200
From: Wolfgang Haeuptli <haeuptli@x8.net>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: FBDev-eror: FBIOPUTCMAP, is there a patch ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello

I'm fighting with:

Fatal server error:
fbdevUpdateColormap: FBIOPUTCMAP failed

which crashes my WM when the screensaver kicks in.
(using cfb16 driver on kernel 2.2.6-15apmac)

some people from the user list suggested to update WindowMaker, but the
problem seems to be in FBDev. (same thing happens in blackbox)
Is there a patch to the kernel sources to fix the problem? (I'd prefer
to recompile the kernel instead of downloading a whole new FBDev-rpm)

Thanks a lot

Wolfgang Haeuptli

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
