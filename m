To: linuxppc-dev@lists.linuxppc.org
Subject: Re: XF68_FBDev under MkLinux?
In-Reply-To: Your message of "Sat, 5 Dec 1998 23:12:03 -0600"
	<19981205231203.A1422@merelda.uiuc.edu>
References: <19981205231203.A1422@merelda.uiuc.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19981207014016F.roikawa@rr.iij4u.or.jp>
Date: Mon, 07 Dec 1998 01:40:16 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: anthony tong <atong@uiuc.edu>
Subject: Re: XF68_FBDev under MkLinux?
> 
> Geert Uytterhoeven (Sat, Dec 05, 1998 at 11:20:33PM +0100):
> >   2. Adopt XF68_FBdev so it can use the MkLinux video mode ioctl stuff. This
> >      requires no kernel changes. In XF68_FBDev, the video ioctl and mmap stuff
> >      has to be changed slightly.
> > 
> > I think the second solution is the least amount of work.
> 
> Agreed.

Simple question: What is the advantage of fbdev server without
 frame buffer device ?

Please note I am NOT against this project. More possible selection
is better.


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
