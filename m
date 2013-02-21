Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 32E482C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2013 16:50:23 +1100 (EST)
Message-ID: <1361425813.4676.47.camel@pasglop>
Subject: Re: linux-next: manual merge of the signal tree with the powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 20 Feb 2013 23:50:13 -0600
In-Reply-To: <20130221155208.bcb1295ab9bdecf394d48bfc@canb.auug.org.au>
References: <20130221155208.bcb1295ab9bdecf394d48bfc@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Al Viro <viro@ZenIV.linux.org.uk>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-02-21 at 15:52 +1100, Stephen Rothwell wrote:
> Hi Al,
> 
> Today's linux-next merge of the signal tree got conflicts in
> arch/powerpc/kernel/signal_32.c and arch/powerpc/kernel/signal_64.c
> between commit 2b0a576d15e0 ("powerpc: Add new transactional memory state
> to the signal context") from the powerpc tree and commit 7cce246557bf
> ("powerpc: switch to generic sigaltstack") from the signal tree.
> 
> I fixed it up (I think - see below) and can carry the fix as necessary
> (no action is required).

Mikey, can you check everything's all right ?

I'm happy to wait for Al stuff to go in first & fixup the conflict
before I send the pull request to Linus. I'm off travelling around but I
should be able to get stuff out this week-end.

Cheers,
Ben.
