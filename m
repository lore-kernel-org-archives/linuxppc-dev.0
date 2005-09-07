Return-Path: <rober@opnet.com.tw>
Received: from opnet2.opnet.com.tw (unknown [210.243.240.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9471B681B7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 18:44:08 +1000 (EST)
Received: from [10.0.14.26] (h248-210-243-240.opnet.com.tw [210.243.240.248]
	(may be forged))
	by opnet2.opnet.com.tw (8.13.3/8.13.1) with ESMTP id j87Ga6ch070397
	for <linuxppc-embedded@ozlabs.org>; Wed, 7 Sep 2005 16:36:07 GMT
	(envelope-from rober@opnet.com.tw)
From: =?UTF-8?Q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?=
	<rober@opnet.com.tw>
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Wed, 07 Sep 2005 16:43:54 +0800
Message-Id: <1126082634.17291.9.camel@banana>
Mime-Version: 1.0
Subject: lost "Using multi-level CPM interrupts" option
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All:

     I used patch file (patch-denx-linuxppc_2_4_devel-2005_06_23_1722)
to patch 2.4.25 Linux,
but this patch file didn't contain " Using multi-level CPM interrupts"
option.Why?

   I used RTAI  that version is stromboli and I want to run  example
cpm_irqs.c.

Best Regards,
Rober Hsu
