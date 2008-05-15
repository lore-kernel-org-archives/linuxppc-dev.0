Return-Path: <akpm@linux-foundation.org>
Date: Wed, 14 May 2008 18:30:32 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Nick Piggin <npiggin@suse.de>
Subject: Re: [patch 4/4] spufs: convert nopfn to fault
Message-Id: <20080514183032.23f9e511.akpm@linux-foundation.org>
In-Reply-To: <20080515005305.GD30448@wotan.suse.de>
References: <200805142312.m4ENCtlq026265@imap1.linux-foundation.org>
	<20080515005305.GD30448@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 May 2008 02:53:05 +0200 Nick Piggin <npiggin@suse.de> wrote:

> Thanks for helping out with merging these Andrew. The problem with
> this is that these nopfn conversions won't work unless the
> BUG_ON is removed from mm/memory.c (patch 1/ that I sent you).

oh.

> So
> there is a little dependency chain here. I guess you could send
> that patch 1 upstream ASAP, and then let the subsequent non trivial
> patches filter up in their own time. I don't know, just a heads up.

OK, I'll include mm-allow-pfnmap-faults.patch in the next linuswards
batch.
