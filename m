Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 58359DDE01
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 16:56:35 +1000 (EST)
Received: from mail01.m-online.net (svr21.m-online.net [192.168.3.149])
	by mail-out.m-online.net (Postfix) with ESMTP id 7368799168
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 08:56:33 +0200 (CEST)
Received: from [10.0.30.2] (p5497F388.dip.t-dialin.net [84.151.243.136])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-auth.mnet-online.de (Postfix) with ESMTP id 52FF0BAE3D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Apr 2007 08:56:33 +0200 (CEST)
Message-ID: <462864CA.7050601@grandegger.com>
Date: Fri, 20 Apr 2007 08:59:22 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: FDT for MPC5200, CPU revision, MSCAN
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

is there a way to distinguish the CPU revision (Rev.A vs. Rev.B) of the 
MPC5200, preferably at run time? Or should this be defined in the FDT?
I ask, because some settings depend on the CPU revision due to hardware 
bugs, like the clock source used for MSCAN.

Thanks.

Wolfgang.
