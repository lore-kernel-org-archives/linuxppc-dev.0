Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7B21567BD3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Jul 2005 01:28:09 +1000 (EST)
Date: Thu, 7 Jul 2005 08:28:05 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: David Grab <d.grab@hima.com>
Message-ID: <20050707152804.GA25876@gate.ebshome.net>
References: <001401c58300$3643f870$f201a8c0@SN7606>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <001401c58300$3643f870$f201a8c0@SN7606>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC440GX IBM EMAC2/3 RGMII mode selection
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Jul 07, 2005 at 04:28:57PM +0200, David Grab wrote:
> i have some problems to configure emac2, emac3 support of my ibm ppc440gx
> for linux kernel 2.6.11.6. I have two RGMII Phy?s connected to the ppc an no
> other PHY?s are connected. PPC Strapping is selected for Group4 (SMII, SMII,
> RGMII/RTBI, RGMII/RTBI). I only want to configure the RGMII support of emac2
> and emac3. But it seems like the PHY?s are used for eth0 (emac1) and eth1
> (emac2) which are configured as SMII. Could someone tell me, what i have to
> configure to select only emac2 and emac3 in RGMII mode?

Quick hack would be commenting out EMAC0 and EMAC1 ocp_def in 
arch/ppc/platforms/4xx/ibm440gx.c.

Let me know if it works, and I'll think about more clean way to do 
this.

-- 
Eugene
