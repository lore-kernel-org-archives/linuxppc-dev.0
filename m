Return-Path: <anton@ozlabs.org>
Date: Tue, 8 Dec 2009 12:35:28 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4] powerpc: Reduce differences between pseries and
	ppc64 defconfigs
Message-ID: <20091208013528.GA2716@kryten>
References: <20091207034509.GA3421@kryten> <20091207034555.GB3421@kryten>
	<20091207034714.GC3421@kryten> <1260235641.4668.1.camel@concordia>
	<1260235944.10809.23.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1260235944.10809.23.camel@pasglop>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi,

> Also no NUMA is going to hurt Cell too. I think we should leave that in.

It was never enabled in the ppc64 defconfig :) I'm happy to turn it on though.

Anton
