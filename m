To: Christian.Bauer@uni-mainz.de
Cc: Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org
Subject: Re: Endianess problems in linuxppc kernel
In-Reply-To: Your message of "Wed, 28 Apr 1999 20:13:55 CEST"
	<199904281818.UAA01127@student.physik.uni-mainz.de>
References: <199904281818.UAA01127@student.physik.uni-mainz.de>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990430022419D.roikawa@rr.iij4u.or.jp>
Date: Fri, 30 Apr 1999 02:24:19 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> >You are using atyfb? What kind of ATI Mach64 chip do you have?
> 
> ATI 264VT2
 As far as I know, ATI 264VT2 has a HW byte-swapper for frame buffer access,
but unfortunately it behaves differently from newer chips(ex. 3D Rage). 
As saying only for X, Xpmac_mga and Xpmac from (Pre)R5 on linuxppc.org have
already contained work around for this.


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
