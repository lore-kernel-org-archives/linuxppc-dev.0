Message-ID: <39CF8EA9.E444E5EE@student.ethz.ch>
Date: Mon, 25 Sep 2000 19:43:05 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: rshapiro@bbn.com
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display, xinerama
References: <Pine.LNX.4.10.10009231028030.26749-100000@apollo.kulian.net>
	 <14798.23332.833379.615321@esb.bbn.com> <39CE8B90.1B318DD2@student.ethz.ch> <14799.19089.742041.388095@esb.bbn.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


R Shapiro wrote:

> I just did it tried running +xinerama with all three monitors at 8pp.
> It works!  Blackbox is happy to move windows across screens, or even
> leave a window half on one and half on another.  Basically just like
> the multiple monitor support that MacOS has always had.
>
> Very nice :)

Cool.


> Btw for those who might want to try this, +xinerama is a server arg so
> the command is  'startx -- +xinerama'.

There's also an option for XF86Config, read the manpage - the logical place
would be in the Layout Section.


Michel


--
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86 and The DRI Project

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
