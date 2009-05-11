Return-Path: <willy@parisc-linux.org>
Received: from mail.parisc-linux.org (palinux.external.hp.com [192.25.206.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.parisc-linux.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6A81CDDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 02:25:17 +1000 (EST)
Date: Mon, 11 May 2009 10:25:11 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: Next May 11 : BUG during scsi initialization
Message-ID: <20090511162511.GG8112@parisc-linux.org>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
	<20090511122135.GC8112@parisc-linux.org>
	<4A08502B.9040001@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4A08502B.9040001@in.ibm.com>
Cc: Nick Piggin <npiggin@suse.de>, Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-scsi <linux-scsi@vger.kernel.org>, chinang.ma@intel.com,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 11, 2009 at 09:49:55PM +0530, Sachin Sant wrote:
> Yeah so the problem seems to be with SLQB. I was able to boot Next 11 with
> SLUB on the same machine.

Is it 100% reproducable with SLQB?  Our errors were fairly hard to tickle
on demand.

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
