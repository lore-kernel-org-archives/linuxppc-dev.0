Return-Path: <domino@mikroswiat.pl>
Received: from jupiter.az.pl (jupiter.az.pl [62.146.68.61])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C10D4DDF69
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Aug 2008 18:11:56 +1000 (EST)
Received: from afp172.internetdsl.tpnet.pl ([83.16.145.172] helo=[192.168.2.8])
	by jupiter.az.pl with esmtpsa (TLSv1:AES256-SHA:256) (Exim 4.68)
	(envelope-from <domino@mikroswiat.pl>) id 1KQHSw-0003yf-LX
	for linuxppc-embedded@ozlabs.org; Tue, 05 Aug 2008 10:00:23 +0200
Message-ID: <4898092D.6040207@mikroswiat.pl>
Date: Tue, 05 Aug 2008 10:02:53 +0200
From: Dominik Bozek <domino@mikroswiat.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: gianfar on mpc8313
Content-Type: text/plain; charset=ISO-8859-2
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,
do someone know how to speedup the gianfar on mpc8313? (core:333MHz,
csb:133MHz, ddr:266MHz)
I'm able to achieve 56MB/s (from device) and 48MB/s (to device), but
only if the ethernet interface use jumbo packets (mtu 9000). With
default mtu the transfers are 33MB/s and 27MB/s.
I'm using kernel 2.6.20 + patches from freescale, but I make some tests
with 2.6.26 (eg. because of DMA engine support). I haven't notice any
improvement in the transfer (I don't take care about cpu usage).

Is there anybody who got higher transfers? Can you share some information?

-- 
Regards
Domino
