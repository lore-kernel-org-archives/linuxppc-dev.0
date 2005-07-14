Return-Path: <Joakim.Tjernlund@lumentis.se>
Received: from dmz.lumentis.net (unknown [212.105.56.244])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 460B867C91
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Jul 2005 00:00:10 +1000 (EST)
Received: from Jocke (84-217-0-17.tn.glocalnet.net [84.217.0.17] (may be
	forged)) (authenticated bits=0)
	by dmz.lumentis.net (8.12.8/8.12.8) with ESMTP id j6EDWdVJ023231
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-embedded@ozlabs.org>; Thu, 14 Jul 2005 15:32:40 +0200
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 14 Jul 2005 15:32:36 +0200
Message-ID: <BCEFJBPJCGFCNMMMIDBHAEFDCMAA.Joakim.Tjernlund@lumentis.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: mpc8xx and ld.so problem
Reply-To: Joakim.Tjernlund@lumentis.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Theo Gjaltema wrote:

 > Has anyone an idea why only this large application failed? busybox_1.0
 > and more applications work fine.
 > system is a: mcp862/32Mb SDRAM started from u-boot 0.4.1,
 > kernel enhanced with atm/utopia driver.
 

I think you hit this bug that was fixed a while ago.
http://ozlabs.org/pipermail/linuxppc-embedded/2005-January/016490.html
