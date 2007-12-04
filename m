Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 5/7] powerpc: Replace ppc_md.power_off with pm_power_off
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40712041205o39ba4e3epcbc008ea47bd83cc@mail.gmail.com>
References: <20071204053736.GA27862@mag.az.mvista.com>
	<20071204054821.GF27862@mag.az.mvista.com>
	<1196752989.13230.265.camel@pasglop>
	<20071204180148.GA1579@mag.az.mvista.com>
	<1196798152.13230.308.camel@pasglop>
	<fa686aa40712041205o39ba4e3epcbc008ea47bd83cc@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 05 Dec 2007 07:24:12 +1100
Message-Id: <1196799852.13230.329.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2007-12-04 at 13:05 -0700, Grant Likely wrote:
> We could simply have the setup code copy the ppc_md.power_off pointer
> into pm_power_off; that we retain the nice assignment in
> define_machine(), but eliminate the duplicated calls.

Good idea.

Ben.
