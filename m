Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DCCA2B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 19 Jul 2010 10:09:21 +1000 (EST)
Subject: Re: [PATCH V4] powerpc/prom: Export device tree physical address
	via  proc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
References: <1279120733-13584-1-git-send-email-msm@freescale.com>
	<AANLkTimiM1Ky7aIYoQ3efhivypV90LFG-BpueuaPaiPf@mail.gmail.com>
	<1279207159.30737.11.camel@localhost>
	<AANLkTikIGXBNU7NQEL7riZYB-BJU3jhxauzGo6XhUF3t@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 19 Jul 2010 10:09:13 +1000
Message-ID: <1279498153.10390.1764.camel@pasglop>
Mime-Version: 1.0
Cc: Matthew McClintock <msm@freescale.com>,
	Kumar Gala <kumar.gala@freescale.com>,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-15 at 10:22 -0600, Grant Likely wrote:
> What is your starting point?  Where does the device tree (and
> memreserve list) come from
> that you're passing to kexec?  My first impression is that if you have
> to scrub the memreserve list, then the source being used to
> obtain the memreserves is either faulty or unsuitable to the task.

The kernel should ultimately pass the thing to userspace I reckon, with
an appropriate hook for platform code to insert/recover reserved
regions.

Ben.
