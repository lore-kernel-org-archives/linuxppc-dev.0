Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 90ACFDE17E
	for <linuxppc-dev@ozlabs.org>; Thu,  5 Jun 2008 01:06:25 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: "cell-index" vs. "index" vs. no index in I2C device nodes
Date: Wed, 4 Jun 2008 17:06:21 +0200
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200806041706.21557.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm wondering what is currently recommended in the I2C device tree nodes? The 
current IBM I2C driver (i2c-ibm_iic.c) checks "index" and most FSL dts files 
use "cell-index". Some 4xx dts files implement "cell-index" some have no 
index at all.

So what should be used here. Please advise and I'll prepare a patch for it.

Thanks.

Best regards,
Stefan
