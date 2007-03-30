Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1175208237.3122.78.camel@pmac.infradead.org>
References: <1175208237.3122.78.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <26babf7b7398794f08e7417377b3facc@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
Date: Fri, 30 Mar 2007 15:25:40 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> The old 2.6.16 kernel handled memory statically and it was shown in the
> device tree. The current kernel deals with the hypervisor and hotplugs
> the memory, so we should just ignore anything that's reported in the
> device-tree. This enables the current kernel to be booted from 2.6.16
> without evil hacks in head_64.S to override the device-tree.

Surely when you are booted you already have some
memory plugged for you -- shouldn't that memory be
in the device tree?


Segher
