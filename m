Date: Thu, 28 Oct 1999 02:40:08 -0500
From: anthony tong <atong@uiuc.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Accel ATI Rage 128 support, (another test Xserver)
Message-ID: <19991028024007.B16581@mango.genunix.net>
References: <Pine.SO4.4.04.9910271119020.5658-100000@marrow> <19991028032624B.roikawa@rr.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19991028032624B.roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ryuichi Oikawa (Thu, Oct 28, 1999 at 03:26:24AM +0900):
> I have an Xpmac server with Rage128 acceleration support. If you have ADB
> keyboard and mouse, please try:
>  ftp://ppc.linux.or.jp/pub/users/oikawa/Xserver/hw/powermac/Xpmac-3.3.3.1-19991028.gz
> 

I'm not as far as Ryuichi is, but I finally had some time tonight
to port most of Precision Insight's (slightly buggy) code. It's not
fully accelerated yet and still no 15/16 bpp (haven't had time to
look at it).

You'll need a newer aty128fb patch if you're using a 2.2.x kernel.

ftp://devel.linuxppc.org/users/atong/aty128
	XF86FB_Dev-r128.gz
	aty128fb-oct_28.diff.gz

Because there is unreleased xfree code the server will expire in ~3
weeks. :( Also, do keep in mind that this is an experimental Xserver.

Please test,
-at

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
