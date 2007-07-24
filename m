Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F20DADDEAB
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jul 2007 14:33:36 +1000 (EST)
Subject: RE: [PATCH 1/3] Add a new member name to structure irq_host
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chen Gong-B11801 <G.Chen@freescale.com>
In-Reply-To: <995B09A8299C2C44B59866F6391D2635A69C88@zch01exm21.fsl.freescale.net>
References: <11851892302391-git-send-email-g.chen@freescale.com>
	<11851892311178-git-send-email-g.chen@freescale.com>
	<1185228277.5439.141.camel@localhost.localdomain>
	<1185232974.13740.11.camel@concordia.ozlabs.ibm.com>
	<1185233771.5439.153.camel@localhost.localdomain>
	<995B09A8299C2C44B59866F6391D2635A69C88@zch01exm21.fsl.freescale.net>
Content-Type: text/plain
Date: Tue, 24 Jul 2007 14:33:20 +1000
Message-Id: <1185251600.5439.204.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-07-24 at 12:06 +0800, Chen Gong-B11801 wrote:
> Can you give me a DTS example or code segment? I'm ambiguous about
> what you said. 

Well, you would have to look at a cell blade or pSeries machine
device-tree, I don't have one at hand in DTS form... but basically,
those don't have a 1:1 relationship between hosts and nodes.

Anyway, I discussed with Michael today and it might be a good idea to
provide an optional device node field in the host struct that can be
used by the majority of the PICs that have one host == one node, that
would provide a good default for the name() function.

Ben.
