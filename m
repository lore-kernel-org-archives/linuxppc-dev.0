Return-Path: <amrutasai.p@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.174])
	by ozlabs.org (Postfix) with ESMTP id EC7E0DE060
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 02:49:38 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1194875wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 07:49:37 -0800 (PST)
Message-ID: <dd2f3b320901150749u2312c2f3q909b05c3440f28bc@mail.gmail.com>
Date: Thu, 15 Jan 2009 21:19:37 +0530
From: "Sai Amruta" <amrutasai.p@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: MPC8313 NAND driver limitation
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_267910_14405294.1232034577126"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_267910_14405294.1232034577126
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

System details:
Linux: 2.6.26-1
Processor: MPC8313

The current freescale NAND controller driver is using "command completion
(CC)" interrupt from FCM block to know the completion read and write
operations. After issuing NAND read/write operation and before FCM CC
interrupt, access to other Local Bus chip selects will failed. I have found
that it was a limitation with freescale FCM block.
To come across this limitation, i have implemented busy wait loop in driver.

I have spent lot of effort to find root cause, so that i would like to
publish my observations here which may help somebody who is using MPC8313.
-- 
--Amru

------=_Part_267910_14405294.1232034577126
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>System details:<br>Linux: 2.6.26-1<br>Processor: MPC8313<br clear="all"><br>The
current freescale NAND controller driver is using &quot;command completion
(CC)&quot; interrupt from FCM block to know the completion read and write
operations. After issuing NAND read/write operation and before FCM CC
interrupt, access to other Local Bus chip selects will failed. I have
found that it was a limitation with freescale FCM block.<br>
To come across this limitation, i have implemented busy wait loop in driver.<br><br>I
have spent lot of effort to find root cause, so that i would like to
publish my observations here which may help somebody who is using
MPC8313.<br>-- <br>--Amru<br>

------=_Part_267910_14405294.1232034577126--
