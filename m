To: jk@espy.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Blue G3 and machine check
In-Reply-To: Your message of "Thu, 8 Apr 1999 22:58:36 -0700"
	<v04204d03b333436e691f@[206.163.71.146]>
References: <v04204d03b333436e691f@[206.163.71.146]>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990410011237E.roikawa@rr.iij4u.or.jp>
Date: Sat, 10 Apr 1999 01:12:37 +0900
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Joel Klecker <jk@espy.org>
Subject: Re: Blue G3 and machine check
> >>ftp://ppc.linux.or.jp/pub/users/oikawa/linux-pmac/bluemacg3/vmlinux-2. 
> >>2.1-challenger2.gz
> >>I was given many useful advice on this by Benjamin Herrenschmidt.
> >
> >Any chance you could put up a proper diff for the sources used to build that
> >kernel? I'd really appreciate it. Thanks.
> 
> Since I received absolutely no response to this, let me elaborate. I 
> have had success in booting and running a system with this kernel, 
> but its config does not suit my needs, therefore I really would like 
> to have the source. The pseudo-diffs in the message I originally 
> replied to do not seem to be enough to produce a working kernel, are 
> they really all of the changes?
 Yes, that was all.

> If they are, then I would like a copy 
> of the .config so I can see what the differences in configuration 
> are. Thanks again.
I thought it was almost default...  Then I'll make complete
diff to 2.2.1 kernel from samba and put it later on 
  ftp://ppc.linux.or.jp/pub/users/oikawa/linux-pmac/bluemacg3/ 
But please note that
 - it is minimal workaround and should not be used for long time
 - ultraATA chip(CMD646) driver has not been ported yet, so that
   if you need it, you have to rewrite yourself. But usual ATA bus,
   which CDROM is connected, does work.
 - it is a diff to kernel 2.2.1, not to latest one


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
