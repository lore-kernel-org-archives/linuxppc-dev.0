Date: Mon, 27 Mar 2000 10:05:58 -0800 (PST)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Some issues to resolve with XFree 4.0 yet
In-Reply-To: <20000328024133B.roikawa@rr.iij4u.or.jp>
Message-ID: <Pine.LNX.4.10.10003270958530.10064-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 28 Mar 2000, Ryuichi Oikawa wrote:

> BTW, I noticed an interesting x11perf score. x11perf -scroll500 marked ~300/sec
> for ATI Rage128RE connected to 66MHz bus on B&W G3 rev.1, but ~600/sec for an
> old Matrox Millennium II to 33MHz bus, measured at 32bpp/24bit depth.

are you using the patch I posted last week?  If not, then I suggest you
do.  I fixed the improper load/stores in r128 and it shows a 200% increase
in almost all x11perf tests.  example:

(jack howarth tested these on his g4/450 (rage 128pro?)):

before:
Scroll 500x500 pixels:	583.0/sec

after:
Scroll 500x500 pixels:	1060.0/sec


> Ryuichi Oikawa
> roikawa@rr.iij4u.or.jp

ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
