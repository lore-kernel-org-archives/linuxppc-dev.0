Return-Path: <vijesh.vh@gmail.com>
Received: from rproxy.gmail.com (rproxy.gmail.com [64.233.170.201])
	by ozlabs.org (Postfix) with ESMTP id 4A8BC67A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 19:32:17 +1100 (EST)
Received: by rproxy.gmail.com with SMTP id a36so75738rnf
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 00:32:16 -0800 (PST)
Message-ID: <8e78982e0503180032ddc425e@mail.gmail.com>
Date: Fri, 18 Mar 2005 14:02:16 +0530
From: Vijesh VH <vijesh.vh@gmail.com>
To: linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: SMC91111 Delay Problem
Reply-To: Vijesh VH <vijesh.vh@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, 
I Compiled the SMC91111.c Driver in 2.4.29 Kernel and Booted the
system. I faced a difficulty in delay i.e TX and RX is not properly
working. Any Packet transfer from Chip is not reaching the PHY. But
receives a TX Empty interrupt. Can any one help me.........

-- 
Thanks and Regards,
Vijesh V H
