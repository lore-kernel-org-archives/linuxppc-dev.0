MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <14799.40986.872007.608122@esb.bbn.com>
Date: Mon, 25 Sep 2000 14:57:30 -0400
From: R Shapiro <rshapiro@bbn.com>
To: Michel Dänzer <daenzerm@student.ethz.ch>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: xf 4.0.1 with rage II/rage pro -- multi-headed display, xinerama
In-Reply-To: <39CF8EA9.E444E5EE@student.ethz.ch>
References: <Pine.LNX.4.10.10009231028030.26749-100000@apollo.kulian.net>
	<14798.23332.833379.615321@esb.bbn.com>
	<39CE8B90.1B318DD2@student.ethz.ch>
	<14799.19089.742041.388095@esb.bbn.com>
	<39CF8EA9.E444E5EE@student.ethz.ch>
Reply-To: rshapiro@bbn.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer writes:
 > > Btw for those who might want to try this, +xinerama is a server arg so
 > > the command is  'startx -- +xinerama'.
 >
 > There's also an option for XF86Config, read the manpage - the logical place
 > would be in the Layout Section.

I searched the XF86Config and XFree86 man pages and found no
references to xinerama.  Is it somewhere else?  None of the
ServerLayout settings seem relevant to xinerama as distinguished from
the standard multi-head mode (multiple X screens).

I'd rather put this option in the XF86Config but I can't find a place
for it.


--
rshapiro@bbn.com


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
