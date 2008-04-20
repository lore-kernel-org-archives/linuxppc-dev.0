Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 31086DE1AB
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 07:40:04 +1000 (EST)
Subject: Re: pci issue - wrong detection of pci ressources
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <480BA937.7050603@linux.vnet.ibm.com>
References: <48088F02.2060806@linux.vnet.ibm.com>
	<1208566122.6958.425.camel@pasglop>
	<480BA937.7050603@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Mon, 21 Apr 2008 07:36:48 +1000
Message-Id: <1208727408.7009.0.camel@pasglop>
Mime-Version: 1.0
Cc: Hollis Blanchard <hollisb@us.ibm.com>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Yes you're right. Early at the pci initialization are errors of the allocation for pi ressources.
> And that are exactly the ressources failing later, so that pci initialization seem to be the reason for my problem.
> Was there any simple solution (e.g. just somehow increase memory reserved for pci) when you came across that issue Johan ?

Hrm... I was expecting to see a lot more output here, make sure you have
"debug" on your command line (or enable early debug output, same
effect).

Cheers,
Ben.
