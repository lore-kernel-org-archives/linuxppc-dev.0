Return-Path: <johns.daniel@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id C9524DDF1F
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:53:41 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1071406yxb.39
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 15:53:39 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 10 Mar 2009 17:53:38 -0500
Message-ID: <ba5d9360903101553h3cf7c33ex639999803655c440@mail.gmail.com>
Subject: TSEC/MDIO bug in recent kernels
From: Johns Daniel <johns.daniel@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For those of you who are running into this error:
         24520:01 not found
         eth0: Could not attach to PHY
         IP-Config: Failed to open eth0
         IP-Config: Device `eth0' not found.

There is a bug in recent kernels. I found it in 2.6.28.7:
linux/arch/powerpc/sysdev/fsl_soc.c.~1~:
for_each_compatible_node(np, "mdio", "gianfar");
