To: linuxppc-user@lists.linuxppc.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: C&T acceleration support, needs testers.
In-Reply-To: Your message of "Sun, 01 Aug 1999 00:53:11 GMT"
	<19990801005311S.roikawa@rr.iij4u.or.jp>
References: <19990801005311S.roikawa@rr.iij4u.or.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Message-Id: <19990801234848Q.roikawa@rr.iij4u.or.jp>
Date: Sun, 01 Aug 1999 23:48:48 GMT
From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


From: Ryuichi Oikawa <roikawa@rr.iij4u.or.jp>
Subject: C&T acceleration support, needs testers.
> I'm trying to implement C&T 6555x HW acceleration to the X servers.
> I put a Xpmac binary:
>  ftp://ppc.linux.or.jp/pub/users/oikawa/Xserver/hw/powermac/Xpmac-19990731-glibc2.1.gz
> XF68_FBDev version hasn't been compiled, yet.
 It's just been compiled:
ftp://ppc.linux.or.jp/pub/users/oikawa/Xserver/hw/xfree68/XF68_FBDev-19990801-glibc2.1.gz

 Because FB_ACCEL code isn't defined for C&T 65550 and it requires to accesss
both MMIO and IO space, it scans PCI configuration space through /proc/bus/pci.
I'm not quite sure if it can detect C&T 6555x properly (just write and compile,
not checked, yet). I hope Geert or someone accept the patch...


Regards,

Ryuichi Oikawa
roikawa@rr.iij4u.or.jp

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
