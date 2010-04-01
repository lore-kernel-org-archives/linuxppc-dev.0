Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 182B1B7D0E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  1 Apr 2010 13:39:16 +1100 (EST)
Subject: Re: spin_lock_irqsave and multi-core
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: gshan <Gavin.Shan@alcatel-lucent.com>
In-Reply-To: <4BB3FE05.6040800@alcatel-lucent.com>
References: <4BB3FE05.6040800@alcatel-lucent.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 01 Apr 2010 13:39:05 +1100
Message-ID: <1270089545.7101.84.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-04-01 at 09:59 +0800, gshan wrote:
> On multi-core system, spin_lock_irqsave() can stop all CPU cores 
> receiving interrupts?

No.

> If the answer is no, what we can do to disable external interrupt for 
> all CPU cores?

You don't :-)

Really, you generally don't. Why would you want to do that ?

Cheers,
Ben.
