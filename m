Return-Path: <benh@kernel.crashing.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bogdan Antonovici <bantonovici@priority.mb.ca>
In-Reply-To: <000d01c5911b$0f049430$cd01a8c0@DESIGNLAB>
References: <1121959795.800.18.camel@rd-lab>
	<1a928a85f53f5dcd972161356611a312@embeddededge.com>
	<1122047198.6726.13.camel@rd-lab> <20050722125750.GA5950@dmt.cnet>
	<000d01c5911b$0f049430$cd01a8c0@DESIGNLAB>
Content-Type: text/plain
Date: Mon, 25 Jul 2005 13:36:34 -0400
Message-Id: <1122312994.14393.176.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, ppckernel <ppckernel@ppckernel.org>,
	linuxppc-embedded@ozlabs.org
Subject: Re: swap_dup: Bad swap file entry 00480020
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2005-07-25 at 08:16 -0500, Bogdan Antonovici wrote:
> Yes, it was. After some research on the previous message i realized
> that it run out of memory so i did mem=8M and it hasn't been crashed
> since then.
> I still would like to understand why that swap code was run when the
> swapping wasn't activated at all.

The "swap" code also kicks in for things like mmap of a file, this is
the same code path.

Ben.
