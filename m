Message-ID: <37D8A113.E95181A5@loomer.com>
Date: Thu, 09 Sep 1999 23:11:32 -0700
From: Hugh Caley <hcaley@loomer.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Problems with Samba 2.2 tree
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


FYI, Paul, I have been rsyncing the stable tree on my Lombard laptop, and I
haven't been able to boot the kernels built with it since sometime after 9/3
or so.

I get the "booting" line, but the little Tux pic never comes up and it hangs
there (I have waited for disk activity to continue for a couple of minutes
afterwards).

I have tried it at both 16 and 32 bpp, and with and without the Video Driver
checkbox in bootx.  Current kernel args are:

video=atyfb:vmode:16,cmode:32,mclk:67 (I've also tired mclk:100).

This is with the 2.95 gcc from dev.linuxppc.org; I then downgraded and tried
it with egcs 1.1.2 from there; same thing.

Hugh

--
Hugh Caley, Unix Administrator
Babcock & Brown, San Francisco
510-524-1672
hughc@babcockbrown.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
