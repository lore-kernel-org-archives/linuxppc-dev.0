Return-Path: <wilhardt@wilhardts.com>
Received: from ylpvm12.prodigy.net (ylpvm12-ext.prodigy.net [207.115.57.43])
	by ozlabs.org (Postfix) with ESMTP id 63C4C68802
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 15:24:47 +1100 (EST)
Received: from ylpvm01.prodigy.net (ylpvm01-int.prodigy.net [207.115.5.207])
	by ylpvm12.prodigy.net (8.12.10 outbound/8.12.10) with ESMTP id
	jBJ492KK005192
	for <linuxppc-embedded@ozlabs.org>; Sun, 18 Dec 2005 23:09:02 -0500
Message-Id: <200512190413.jBJ4D9nd031244@ylpvm01.prodigy.net>
From: <wilhardt@wilhardts.com>
To: "'Sam Song'" <samlinuxppc@yahoo.com.cn>,
	"'Lance Ware'" <lware@datadesigncorp.net>
Date: Sun, 18 Dec 2005 20:09:02 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
In-Reply-To: <20051219025133.54341.qmail@web15807.mail.cnb.yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: SMP on MV64460
Reply-To: wilhardt@wilhardts.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


There are a few of examples of SMP using the MV64460 from Curtiss =
Wright,
but I don't know of a 7447A SMP (you really need a backside external =
cache
to take advantage of SMP).  The CWCEC boards support 2.4 or 2.6.

http://www.cwembedded.com/products/0/2/151.html/


-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Sam Song
Sent: Sunday, December 18, 2005 6:52 PM
To: Lance Ware
Cc: linuxppc-embedded@ozlabs.org
Subject: Re : SMP on MV64460

Lance Ware <lware@datadesigncorp.net> wrote:
> I am currently working on a board which has
> MV64460 linked between two 7447a processors.  I
> wanted to know if someone has been able to get
> the Linux 2.6 kernel working with any MV64xxx
> bridge.

I happen to have such a board, DB64460-BP, on
hand.=20
But even 2.4 kernel has some problems with
MV64460
PCI part. I wonder whether there is a 2.4 version

support that with PCI device like VGA card.=20

Thanks,

Sam


__________________________________________________
=B8=CF=BF=EC=D7=A2=B2=E1=D1=C5=BB=A2=B3=AC=B4=F3=C8=DD=C1=BF=C3=E2=B7=D1=D3=
=CA=CF=E4?
http://cn.mail.yahoo.com
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
