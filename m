Return-Path: <srinivas.surabhi@wipro.com>
Received: from wip-ectls-mx3.wipro.com (wip-ectls-mx3.wipro.com
	[203.101.113.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wip-ectls-mx3.wipro.com",
	Issuer "certserv.wipro.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id AD16467A6E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Feb 2005 00:27:54 +1100 (EST)
Received: from wip-ectls-mx3.wipro.com (localhost.localdomain [127.0.0.1])
	by localhost (Postfix) with ESMTP id 564E32242A4
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 19:55:39 +0530 (IST)
Received: from blr-ec-bh1.wipro.com (blr-ec-bh1.wipro.com [10.200.50.91])
	by wip-ectls-mx3.wipro.com (Postfix) with ESMTP id 4A1BC2240D8
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 19:55:39 +0530 (IST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 22 Feb 2005 18:57:18 +0530
Message-ID: <EF9B29C78F41FA488927FCBC7750AF0E011DA6BE@hyd-mdp-msg.wipro.com>
From: <srinivas.surabhi@wipro.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: GLIBC_2.0 not defined  in libc.so.6 ---- problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Hi,

I am facing the following problem with kernel 2.4.20. Can any body throw
light on it?

...
Freeing unused kernel memory: 56k init
init: relocation error: init: symbol optarg, version GLIBC_2.0 not
defined in file libc.so.6 with link time reference
Kernel panic: Attempted to kill init!


My one more doubt is the file libc.so.6 is it mandatory to be linked?

Thanks in advance=0D
-SS



Confidentiality Notice=0D

The information contained in this electronic message and any attachments to=
 this message are intended
for the exclusive use of the addressee(s) and may contain confidential or=
 privileged information. If
you are not the intended recipient, please notify the sender at Wipro or=
 Mailadmin@wipro.com immediately
and destroy all copies of this message and any attachments.
