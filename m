MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <14799.19089.742041.388095@esb.bbn.com>
Date: Mon, 25 Sep 2000 08:52:33 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michel Dänzer <daenzerm@student.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display, xinerama
In-Reply-To: <39CE8B90.1B318DD2@student.ethz.ch>
References: <Pine.LNX.4.10.10009231028030.26749-100000@apollo.kulian.net>
	<14798.23332.833379.615321@esb.bbn.com>
	<39CE8B90.1B318DD2@student.ethz.ch>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer writes:
 > > I can't test xinerama on this platform because the three screen don't
 > > all run at same depth (two use depth 15/16, one uses depth 8).
 >
 > What about just testing it with the two heads who run at 16 bpp, or run all
 > heads in depth 8?


I just did it tried running +xinerama with all three monitors at 8pp.
It works!  Blackbox is happy to move windows across screens, or even
leave a window half on one and half on another.  Basically just like
the multiple monitor support that MacOS has always had.

Very nice :)

Btw for those who might want to try this, +xinerama is a server arg so
the command is  'startx -- +xinerama'.


--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
