Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B64E7DDE1E
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 05:13:10 +1000 (EST)
In-Reply-To: <1C929A99-BA1D-452C-AD54-66D42DBC8D23@kernel.crashing.org>
References: <20070731230932.a9459617.akpm@linux-foundation.org>
	<200708011002.30962.m.kozlowski@tuxland.pl>
	<18096.24918.111376.805855@cargo.ozlabs.ibm.com>
	<200708021214.51705.m.kozlowski@tuxland.pl>
	<1C929A99-BA1D-452C-AD54-66D42DBC8D23@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <81739136c762bc2c6ef170445d93d30d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: 2.6.23-rc1-mm2
Date: Mon, 6 Aug 2007 21:12:27 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-usb-devel@lists.sourceforge.net, gregkh@suse.de,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Some how your defconfig is targeting a PPC64 box:
>
> CONFIG_PPC64=y
>
> shouldn't be set if you want to build a kernel for a G3 imac.

allyesconfig/allmodconfig select a 64-bit build always.  Maybe
it shouldn't.


Segher
