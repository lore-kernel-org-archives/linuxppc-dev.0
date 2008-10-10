Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5AD25DE240
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Oct 2008 10:19:52 +1100 (EST)
Subject: Re: [PATCH] powerpc: Add legacy PCI access via sysfs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jesse Barnes <jbarnes@virtuousgeek.org>
In-Reply-To: <200810100902.30191.jbarnes@virtuousgeek.org>
References: <20081010025101.B48CADDEF7@ozlabs.org>
	<200810100902.30191.jbarnes@virtuousgeek.org>
Content-Type: text/plain
Date: Sat, 11 Oct 2008 10:19:45 +1100
Message-Id: <1223680785.8157.168.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-pci@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-10-10 at 09:02 -0700, Jesse Barnes wrote:
> Ah I was worried the first one might need a respin, but it applied
> fine, so 
> I'll go ahead and apply this one too.

Let's hope it doesn't collide with the pending powerpc.git merge...

Ben.
