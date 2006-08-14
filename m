Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17631.62819.24167.555967@cargo.ozlabs.ibm.com>
Date: Mon, 14 Aug 2006 14:00:35 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Albert Cahalan" <acahalan@gmail.com>
Subject: Re: [PATCH] no-execute -- please test
In-Reply-To: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
References: <787b0d920608132020q4ad2b5c2y49e25ca7ecc33536@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Albert Cahalan writes:

> This kernel patch implements no-execute protection (like x86 "NX bit")
> for the Mac G2, Mac G3, Mac G4, and other systems running 32-bit
> PowerPC processors in the 6xx, 7xx, and 7xxx families.

I'd be interested in benchmark comparisons with/without this patch, if
anyone cares to run lmbench, kernbench etc. with and without...  If
the performance impact is minimal I'll be happy to apply it.  If the
impact is noticeable then it might need to be selectable with a config
option.

Paul.
