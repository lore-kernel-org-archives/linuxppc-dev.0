Return-Path: <anton@ozlabs.org>
Date: Sun, 8 Oct 2006 00:58:11 +1000
From: Anton Blanchard <anton@samba.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: vsdo_datapage.h WTF?
Message-ID: <20061007145811.GA4043@krispykreme>
References: <1160148208.4795.30.camel@pmac.infradead.org>
	<1160170374.22232.135.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1160170374.22232.135.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> No. There -used- to be this systemcfg structure that was exposed to
> userspace on ppc64. I made it deprecated. However, for the sake of
> backward compatbility, I kept vdso datapage with the exact same layout
> for the first part of it (before the syscall maps) and haven't removed
> the mmap call for it, but it will be gone soon.

We need a way to export cache size/associativity information (sysfs,
/proc/device-tree parsing?) and a plan to fix the applications using it
first.

Anton
