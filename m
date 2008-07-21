Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 657FDDDED6
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 13:40:41 +1000 (EST)
Date: Sun, 20 Jul 2008 20:40:08 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: benh@kernel.crashing.org
Subject: Re: [PATCH v3] elf loader support for auxvec base platform string
Message-Id: <20080720204008.8927460c.akpm@linux-foundation.org>
In-Reply-To: <1216610655.11027.80.camel@pasglop>
References: <1216166331-14810-1-git-send-email-ntl@pobox.com>
	<1216166331-14810-2-git-send-email-ntl@pobox.com>
	<1216276539.7740.309.camel@pasglop>
	<20080717000951.5f8cab37.akpm@linux-foundation.org>
	<20080717221932.GL9594@localdomain>
	<20080717154218.8981035c.akpm@linux-foundation.org>
	<487FD74C.4080603@BitWagon.com> <20080718182850.GO9594@localdomain>
	<1216610655.11027.80.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: John Reiser <jreiser@BitWagon.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	torvalds@linux-foundation.org, roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 21 Jul 2008 13:24:15 +1000 Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2008-07-18 at 13:28 -0500, Nathan Lynch wrote:
> > John Reiser wrote:
> > > Andrew Morton wrote:
> > > > On Thu, 17 Jul 2008 17:19:32 -0500
> > > > Nathan Lynch <ntl@pobox.com> wrote:
> > > > 
> > > > 
> > > >> [snip]
> > > >> A new aux vector entry, AT_BASE_PLATFORM, will denote the actual hardware.
> > > [snip]
> > > 
> > > > OK.
> > > > 
> > > > But it conflicts directly with the already-queued
> > > > execve-filename-document-and-export-via-auxiliary-vector.patch
> > 
> > Okay, I can rebase on -mm.
> 
> Andrew, we have one other patch (the powerpc bits) on top of that one.
> Do you want to carry both in -mm on top of John's patch ? We would like
> that in .27 though, I don't know what your merge plans are for John's
> patch.
> 

How about I send John's patch Linuswards right now?
