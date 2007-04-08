Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5B7D0DDECF
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 Apr 2007 21:35:44 +1000 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 22CFA98467
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 Apr 2007 13:35:42 +0200 (CEST)
Received: from [10.0.30.2] (p5497DFDC.dip.t-dialin.net [84.151.223.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 05B5A90131
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 Apr 2007 13:35:41 +0200 (CEST)
Message-ID: <4618D400.8050003@grandegger.com>
Date: Sun, 08 Apr 2007 13:37:36 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Flat device tree definitions for FLASH and MTD partitioning
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

are there already some thought or even example code on how to define 
Flash memory and MTD partitions in the DTS. This would avoid the ackward 
MTD partitioning via static structure or boot line argument and could be 
done in a generic way.

Thanks.

Wolfgang.
