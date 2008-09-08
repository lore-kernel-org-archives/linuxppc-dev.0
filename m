Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18628.49658.493975.832802@cargo.ozlabs.ibm.com>
Date: Mon, 8 Sep 2008 16:11:06 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.27-rc5-mm1 mystery trace
In-Reply-To: <20080904202032.2299c2c8.akpm@linux-foundation.org>
References: <20080904202032.2299c2c8.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton writes:

> a) someone broke powerpc's kallsyms processing and

That would be h8300-kallsyms-exclude-local-symbols.patch, which
excludes symbols starting with '.' on all architectures, despite the
name of the patch.

Paul.
