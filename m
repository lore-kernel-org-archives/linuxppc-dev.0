Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 85A9FDDF31
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 05:40:06 +1000 (EST)
In-Reply-To: <484C1F6C.9000108@grandegger.com>
References: <4847A8DA.6010406@grandegger.com>
	<1212825701.32207.403.camel@pmac.infradead.org>
	<20080607114438.GA23329@polina.dev.rtsoft.ru>
	<484C1F6C.9000108@grandegger.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0909149cc236822d193338c5eeb4e4b4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v2] [NAND] driver extension to support NAND on TQM85xx
	modules
Date: Sun, 8 Jun 2008 21:39:44 +0200
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I see. I think I should then also post the bindings (update of
> booting-without-of.txt) separately.

Yes please.  They are much easier to review that way (and they
should be reviewed as a separate entity anyway).


Segher
