Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 16E3BDDE49
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 08:43:47 +1000 (EST)
Subject: Re: eeh bug
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070517164438.GD4325@austin.ibm.com>
References: <1179377184.32247.274.camel@localhost.localdomain>
	<1179377946.32247.281.camel@localhost.localdomain>
	<20070517164438.GD4325@austin.ibm.com>
Content-Type: text/plain
Date: Fri, 18 May 2007 08:43:39 +1000
Message-Id: <1179441819.32247.317.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-17 at 11:44 -0500, Linas Vepstas wrote:
> I'll take a look. Usually, there's no pci_dev only when its a slot
> with no device plugged into it; these can still receive EEH errors
> during config space i/o to the bridge (I presume that the
> justification
> is when aluminum scrap shorts out a pci connector or something like
> that). In all other cases, there's a pci_dev, which is why the 
> bug slipped by.

Hrm... in that case, there's a device in. I'll try to track down why we
don't get it.

Ben.
