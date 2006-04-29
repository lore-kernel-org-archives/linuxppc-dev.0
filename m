Return-Path: <akpm@osdl.org>
Date: Fri, 28 Apr 2006 19:47:46 -0700
From: Andrew Morton <akpm@osdl.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 0/4] NUMA support for spufs
Message-Id: <20060428194746.531b1a4f.akpm@osdl.org>
In-Reply-To: <17490.53283.417700.559725@cargo.ozlabs.ibm.com>
References: <20060429011827.502138000@localhost.localdomain>
	<17490.53283.417700.559725@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org, arnd@arndb.de,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras <paulus@samba.org> wrote:
>
> Arnd Bergmann writes:
> 
> > The current version of spufs breaks upon boot when NUMA support is enabled.
> > I'd like to fix that before 2.6.17 so we can use the same kernel image
> > on Cell that we use on other powerpc systems using NUMA.
> 
> Andrew,
> 
> If 2/4 of this series looks OK to you to go into 2.6.17,

OK by me.  1/4 touches __add_pages(), which it undergoing quite a bit of
churn at present, but we'll work it out.

> let me know
> and I'll push the others to Linus (or you can if you prefer).

I'll queue all four for the next batch (within the next 48 hours).  If you
merge them first then no probs.
