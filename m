To: speedy@carboncode.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: C&T acceleration support, needs testers.
In-Reply-To: Your message of "Sat, 31 Jul 1999 18:56:20 -0700"
	<199907312248.QAA05182@carboncode.com>
References: <199907312248.QAA05182@carboncode.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990802030722A.roikawa@rr.iij4u.or.jp>
Date: Mon, 02 Aug 1999 03:07:22 GMT
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi, 
Thank you for responses.

From: Don Lunder <speedy@carboncode.com>
Subject: Re: C&T acceleration support, needs testers.
> I'll keep playing with it, and tell you what I find, if you have any 
> specific requests, please do ask!

I'd like to further know,

- Difference between 8bp and 16bpp. 8bpp doesn't cause endiannes problem but
 may be more unstable.

- Vertical band problem, more precisely(ex. both 8 and 16bpp? happens
 at what X command? appearing location and size?, etc.)

- Difference between chipsfb and offb(BootX' "no video driver").
  When kernel booted with "no video driver", Xpmac with -ct6555 option
  does BitBLT origin offset calculation, color palette handling and aperture
  setting. I have report that reading color palette immediately causes
  machine check exception resulting in kernel panic(why??). And if aperture
  setting is failed, Xpmac goes into infinite loop.

> PS After Spell checking the email, I see that register has a typo in the 
> Xpmac out put. <shrug>
Oops! :-)

Anyway, I'll soon upload the source code(at the same place, please check)
so that anyone can try and fix it, before I'm on a vacation.

In the mean time, I had a advice that I should end it and spend time
for new XFree(4.0). I'd be glad if someone continued to work on this,
though I haven't decided anything yet.


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
