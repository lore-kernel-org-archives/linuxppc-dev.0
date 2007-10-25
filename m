Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id AE52CDDE41
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 Oct 2007 00:20:25 +1000 (EST)
Received: from mail01.m-online.net (mail.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id BAB0F22425C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 16:20:23 +0200 (CEST)
Received: from [10.0.30.2] (p5497D720.dip.t-dialin.net [84.151.215.32])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 9B446901E3
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 Oct 2007 16:20:23 +0200 (CEST)
Message-ID: <4720A628.8010108@grandegger.com>
Date: Thu, 25 Oct 2007 16:20:24 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: PCI on Lite5200/Icecube, known issues?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

The access to PCI memory space does not to work (I allways read 0xff) on 
my Icecube-Eval-Board. Are there any known issues/bugs with using the 
PCI on the Lite5200/Icecube board with 2.6.23? Has it been tested? I 
realized, that CONFIG_PCI is not set in the default configuration.

Thanks,

Wolfgang.
