Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw4.extranet.tce.com (dmzraw4.extranet.tce.com
	[157.254.234.139]) by ozlabs.org (Postfix) with ESMTP id AA51068404
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 18:12:16 +1000 (EST)
Received: from indyvss3.am.thmulti.com (unknown [157.254.92.62])
	by dmzraw4.extranet.tce.com (Postfix) with ESMTP id C9BA71291
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 08:12:14 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by indyvss3.am.thmulti.com (Postfix) with ESMTP id 9364E3B725
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 08:12:14 +0000 (GMT)
Received: from indyvss3.am.thmulti.com ([127.0.0.1])
	by localhost (indyvss3 [127.0.0.1]) (amavisd-new, port 10024) with LMTP
	id 20377-01-13 for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 08:12:09 +0000 (GMT)
Received: from smtprelay2.indy.tce.com (smtprelay2.indy.tce.com
	[157.254.96.95])
	by indyvss3.am.thmulti.com (Postfix) with ESMTP id 752BF3B70D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 08:12:09 +0000 (GMT)
Received: from boulsmailbh02.eu.thmulti.com (localhost [127.0.0.1])
	by smtprelay2.indy.tce.com (8.12.9/8.12.8) with ESMTP id j8S8C4gx018716
	for <linuxppc-embedded@ozlabs.org>; Wed, 28 Sep 2005 08:12:08 GMT
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 28 Sep 2005 10:12:04 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0DF7@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: How to use SPE on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Bonjour G=E9rard,

G=E9rard Gu=E9vel wrote:
>I don't especially want to see if the bit is set, I just want
>to improve the board performance for a Linux application :-).

Do you know where your CPU is spending much of its time?
It looks like a job for OProfile. Support for e500 exists in 2.6.x=20
thanks to the fine folks of Freescale. We appreciate their involvement=20
in OSS community.

>To check the performance, I used the Dhrystone 2.1 benchmark=20

I like the lmbench microbenchmark too. It depends on what profile
is your application (instruction mix, library calls, cache usage, =
paging,..)

>with the standard glibc (strcpy, strcmp, ...) on one part, and with
>the freescale SPE library on the other part (vstrcpy, vstrcmp, ...).

Will the SPE enhanced C library calls will be integrated in Glibc one =
day?=20


Regards,
Stephane
