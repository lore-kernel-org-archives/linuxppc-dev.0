Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 802FB1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 31 Oct 2010 22:28:30 +1100 (EST)
Subject: Re: PowerMac G4 RAM
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <AANLkTi=+kF+c=RC09_4V2wqw61xFhFHnvqYHAKbA0TpQ@mail.gmail.com>
References: <AANLkTi=+kF+c=RC09_4V2wqw61xFhFHnvqYHAKbA0TpQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 31 Oct 2010 22:28:24 +1100
Message-ID: <1288524504.7329.12.camel@pasglop>
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

On Sat, 2010-10-30 at 22:48 -0500, kevin diggs wrote:
> Hi,
> 
> I have a G4 that has 1.25 G of ram. Under Linux I only get 768M?
> Anyone know why? It is a GiGE with a dual 7455 PowerLogix cpu upgrade.
> Kernel is 2.6.28.

Tried enabling CONFIG_HIGHMEM ?

Cheers,
Ben.
