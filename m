Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D1BCB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Sep 2009 14:55:19 +1000 (EST)
Subject: Re: Driver for using MPC8572's eTSEC1&2 in 16b encoded FIFO Mode?
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <129569.34809.qm@web37905.mail.mud.yahoo.com>
Date: Tue, 15 Sep 2009 23:55:13 -0500
Message-Id: <25846D9B-4006-474E-9D77-013AB455E226@kernel.crashing.org>
References: <129569.34809.qm@web37905.mail.mud.yahoo.com>
To: Christopher Best <kb3dxr@yahoo.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 15, 2009, at 1:37 PM, Christopher Best wrote:

>  On the MPC8572, eTSEC1 and eTSEC2 can be configured to jointly  
> operate in 16-bit encoded FIFO mode. Is there currently a Linux  
> driver for interfacing with this FIFO mode?

Not that I'm aware of.  You should be able to modify drivers/net/ 
gianfar.c for this purpose.

- k
