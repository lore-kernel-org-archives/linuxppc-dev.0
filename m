Return-Path: <anton@ozlabs.org>
Date: Sun, 8 Oct 2006 01:21:12 +1000
From: Anton Blanchard <anton@samba.org>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: vsdo_datapage.h WTF?
Message-ID: <20061007152112.GB4043@krispykreme>
References: <1160148208.4795.30.camel@pmac.infradead.org>
	<1160170374.22232.135.camel@localhost.localdomain>
	<20061007145811.GA4043@krispykreme>
	<1160233817.4795.85.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160233817.4795.85.camel@pmac.infradead.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 
> ELF auxvec?

Could do, but there may end up being a lot of information we need to
export (L2/L3 caches etc). ia64 stuffed it all into sysfs (but didnt
make it generic which was a bit annoying - arch/ia64/kernel/topology.c).

One other thing that would be nice is a generic way to detect SMT
siblings.  We could make our /proc/cpuinfo match x86 in this regard, but
/proc/cpuinfo has so many subtle differences between architectures it is
becoming a pain to parse.

Anton
