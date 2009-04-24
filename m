Return-Path: <viro@ftp.linux.org.uk>
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [195.92.253.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 06896DE106
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 00:05:01 +1000 (EST)
Date: Fri, 24 Apr 2009 15:04:45 +0100
From: Al Viro <viro@ZenIV.linux.org.uk>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: Next April 24 : BUG: lock held at task exit time!
Message-ID: <20090424140445.GL8633@ZenIV.linux.org.uk>
References: <20090424150456.ff35e4ea.sfr@canb.auug.org.au>
	<49F1626D.6080102@in.ibm.com>
	<20090424175509.561c96ad.sfr@canb.auug.org.au>
	<Pine.LNX.4.64.0904241249180.20196@blonde.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.64.0904241249180.20196@blonde.anvils>
Sender: Al Viro <viro@ftp.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, peterz@infradead.org,
	LKML <linux-kernel@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Ingo Molnar <mingo@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 24, 2009 at 12:55:44PM +0100, Hugh Dickins wrote:

> Indeed, thanks for the headsup Stephen.  My own config gives, not
> Sachin's message (or not still visibly on screen anyway), but an
> outright panic.  Shame that leaked out into the big world, we'd
> all have preferred a quiet fixup!  Here's a patch, which I'll
> also send as reply to the relevant thread.

Applied, will fold on reorder (since Ingo is asking for what will amount
to reorder anyway).
