Return-Path: <anton@ozlabs.org>
Date: Wed, 18 Feb 2009 17:20:05 +1100
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Enable hashdist by default on PowerPC
Message-ID: <20090218062005.GB32195@kryten>
References: <20090218051112.GA32195@kryten>
	<1234935667.14060.440.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1234935667.14060.440.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi Ben,

> You have numbers ? :-) I'm asking mostly because I've been wondering
> whether it offsets the 16M pages vs. 4K or 64K pages in term of TLB/ERAT
> impact.

The speedup is application dependent. Things like linpack usually
improve when you throw more memmory at them.

The potential slowdown will be in heavy dcache use (eg fileserving). We
originally added the large boot time hash code when we were benchmarking
SPECsfs (an NFS benchmark).

We can go back to the old behaviour with the hashdist=0 boot option, so
it's mostly a question of what the default should be.

Anton
