Return-Path: <dibacco@inwind.it>
Received: from smtp2.libero.it (smtp2.libero.it [193.70.192.52])
	by ozlabs.org (Postfix) with ESMTP id 3589D679A6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Feb 2006 06:20:36 +1100 (EST)
Received: from localhost (172.16.1.212) by smtp2.libero.it (7.0.027-DD01)
	id 43E202BB01393AEA for linuxppc-embedded@ozlabs.org;
	Thu, 16 Feb 2006 20:20:34 +0100
Received: from smtp1.libero.it ([172.16.1.224])
	by localhost (asav25.libero.it [193.70.193.12]) (amavisd-new,
	port 10024)
	with ESMTP id 14012-04-9 for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Feb 2006 20:20:33 +0100 (CET)
Received: from libero.it (172.16.1.209) by smtp1.libero.it (7.0.027-DD01)
	id 431C3A4201B54E3A for linuxppc-embedded@ozlabs.org;
	Thu, 16 Feb 2006 20:20:33 +0100
Date: Thu, 16 Feb 2006 20:20:33 +0100
Message-Id: <IUSOE9$EC4195506AF568CD52C1043B94D0CFA5@libero.it>
Subject: module_init macro seems not to work
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@inwind\.it" <dibacco@inwind.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If I use something like:
module_init(cpm_timer_init);

cpm_timer_init is not called when I load the module.

I have to call cpm_timer_init inside init_module() .

Bye,
Antonio.
