To: Geert.Uytterhoeven@cs.kuleuven.ac.be
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: New XF68_FBDev
In-Reply-To: Your message of "Sat, 5 Dec 1998 20:41:05 +0100 (MET)"
	<Pine.LNX.4.02.9812051920540.864-100000@cassiopeia.home>
References: <Pine.LNX.4.02.9812051920540.864-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19981207012607B.roikawa@rr.iij4u.or.jp>
Date: Mon, 07 Dec 1998 01:26:07 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > > Known problems:
> > >   - Twm menus aren't drawn correctly on Mach64.
> >  Try KDE or xv, too. You will see non-update window contents.
> 
> It's been a long time ago I ran KDE on my box. And I never saw the problem with
> xv.
 Sorry, then it is a different(new ?) problem.
 
> > I've made a probably same mistake for Xpmac_mga before(it was
> > fixed for version 981108 or later).
> Hmm, basically what I did to update was create a diff between your 981017-3 and
> 981122 and apply that, with some minor modifications.
 Fix on that was done for pmac*ScreenInit(), not for mach64* funcs.

Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
