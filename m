Return-Path: <olh@suse.de>
Date: Fri, 24 Feb 2006 00:27:17 +0100
From: Olaf Hering <olh@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] change compat shmget size arg to signed
Message-ID: <20060223232717.GB29454@suse.de>
References: <20060224101644.548b0c24.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20060224101644.548b0c24.sfr@canb.auug.org.au>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 On Fri, Feb 24, Stephen Rothwell wrote:

> Does the ltp test fail on a standard kernel(where SHMMAX is 0x2000000), or
> only on a SLES kernel (where SHMMAX is ULONG_MAX)?

It fails with SLES9 and SLES10. SLES9 has 0x2000000 as default.
