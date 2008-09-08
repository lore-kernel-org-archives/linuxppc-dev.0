Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 57C14DDE08
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Sep 2008 16:54:42 +1000 (EST)
Date: Sun, 7 Sep 2008 23:54:09 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.27-rc5-mm1 mystery trace
Message-Id: <20080907235409.b01eaa32.akpm@linux-foundation.org>
In-Reply-To: <18628.49658.493975.832802@cargo.ozlabs.ibm.com>
References: <20080904202032.2299c2c8.akpm@linux-foundation.org>
	<18628.49658.493975.832802@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 8 Sep 2008 16:11:06 +1000 Paul Mackerras <paulus@samba.org> wrote:

> Andrew Morton writes:
> 
> > a) someone broke powerpc's kallsyms processing and
> 
> That would be h8300-kallsyms-exclude-local-symbols.patch, which
> excludes symbols starting with '.' on all architectures, despite the
> name of the patch.
> 

Ah, thanks.
