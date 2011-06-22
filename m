Return-Path: <B04825@freescale.com>
Received: from AM1EHSOBE003.bigfish.com (am1ehsobe003.messaging.microsoft.com
	[213.199.154.206])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2272EB6F9C
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 02:20:44 +1000 (EST)
Message-ID: <4E0215E5.5060606@freescale.com>
Date: Wed, 22 Jun 2011 11:18:45 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: Connecting SGMII PHY to eTSEC1 on P1022
References: <4E021113.10909@embedded-sol.com>
In-Reply-To: <4E021113.10909@embedded-sol.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Felix Radensky wrote:
> What am I doing wrong ?

Can you debug the PHY driver to see if it's getting called and trying to talk to
the PHY itself?

-- 
Timur Tabi
Linux kernel developer at Freescale
