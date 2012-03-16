Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2033BB6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Mar 2012 22:10:35 +1100 (EST)
Date: Fri, 16 Mar 2012 12:10:25 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the trivial tree with the powerpc tree
In-Reply-To: <20120316145658.3fb06c5213dbca29d6898c4b@canb.auug.org.au>
Message-ID: <alpine.LNX.2.00.1203161210030.18356@pobox.suse.cz>
References: <20120316145658.3fb06c5213dbca29d6898c4b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Masanari Iida <standby24x7@gmail.com>,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 16 Mar 2012, Stephen Rothwell wrote:

> Today's linux-next merge of the trivial tree got a conflict in
> drivers/char/viotape.c between commit ba7a4822b48f ("powerpc: Remove some
> of the legacy iSeries specific device drivers") from the powerpc tree and
> commit a7ccf3775219 ("char: Fix typo in viotape.c") from the trivial tree.

Dropped a7ccf3775219 in my tree, thanks for report Stephen.

-- 
Jiri Kosina
SUSE Labs
