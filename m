Return-Path: <Rongqing.Li@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7AB12B6F6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Aug 2011 21:45:07 +1000 (EST)
Message-ID: <4E5614C2.4090705@windriver.com>
Date: Thu, 25 Aug 2011 17:24:18 +0800
From: Rongqing Li <rongqing.li@windriver.com>
MIME-Version: 1.0
To: <linuxppc-dev@lists.ozlabs.org>
Subject: When set mtu 9600 by gfar_change_mtu, the maxfrm register is greater
	than 9600
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Cc: netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi:

When set MTU to 9600 by gfar_change_mtu(), the maxfrm register will
be set to 9728 which is greater than 9600 in gianfar.c.

But the MPC8315 Reference manual says the value of maxfrm can not
greater than 9600.

Is it a defect, Do we need to fix it?


-- 
Best Reagrds,
Roy | RongQing Li
