Return-Path: <steve.yang@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 14625679FB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 May 2006 09:04:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: Routing problem
Date: Mon, 15 May 2006 09:08:15 -0700
Message-ID: <D9055C0A0A86BD4E89AD96A89EA767DB09C061@ALA-MAIL03.corp.ad.wrs.com>
From: "Yang, Steve" <steve.yang@windriver.com>
To: "Antonio Di Bacco" <antonio.dibacco@aruba.it>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Antonio,

Try this:

  sysctl net.ipv4.ip_forward=3D1=20

Regards,=20
Steve Yang
510-749-4535 Alameda
AIM: steveyang4535

-----Original Message-----
From: linuxppc-embedded-bounces+syang=3Dwindriver.com@ozlabs.org
[mailto:linuxppc-embedded-bounces+syang=3Dwindriver.com@ozlabs.org] On
Behalf Of Antonio Di Bacco
Sent: Friday, May 12, 2006 1:53 PM
To: linuxppc-embedded@ozlabs.org
Subject: Routing problem

Hi all,

I have a board with an MPC880 using the tow FECs as two ethernet
interfaces. I tried to enable the ip forwarding with no success. I have
issued  "echo 1=20
> /proc/sys/net/ipv4/ip_forward", is it sufficient to make Linux work as

> a
router?

Bye,
Antonio.=20
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
