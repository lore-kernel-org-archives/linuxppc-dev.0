Return-Path: <pawel.studencki@siemens.com>
Received: from thelpusa.erlm.siemens.de (thelpusa.erlm.siemens.de
	[217.194.34.71]) by ozlabs.org (Postfix) with ESMTP id 645F167FEA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 19:58:23 +1000 (EST)
Received: from medeon.erlm.siemens.de (medeon.erlm.siemens.de [146.254.164.9])
	by thelpusa.erlm.siemens.de (Postfix) with ESMTP id 0A849CBD9D
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 11:45:05 +0200 (CEST)
Received: from nbgh103a.nbg6.siemens.de (nbgh103a.nbg6.siemens.de
	[157.163.55.25])
	by medeon.erlm.siemens.de (Postfix) with ESMTP id B4E6B1634F5
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Aug 2005 11:45:04 +0200 (CEST)
Message-ID: <291992F9ECD9AB4F995C7E96B9A30DC008E081@nbgh103a.nbg6.siemens.de>
From: Studencki Pawel <pawel.studencki@siemens.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Thu, 18 Aug 2005 11:45:04 +0200
MIME-Version: 1.0
Content-Type: text/plain
Subject: segmentaion fault with array[4096]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello,

because I want to do some tests with fusion/RTAI on my mpc852,
I had to downgrade my system to kernel 2.6.10
And I get a strange problem: if I start application with char array size
4096 (or even smaller 2600) I get "segmentation fault".
Could someone gives me a hint? Is this kernel configuration problem?
Where can I start looking for a reason?

thanks
Pawel
