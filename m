Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 188AC1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2011 10:29:27 +1100 (EST)
Message-ID: <1320622150.2779.6.camel@pasglop>
Subject: New location of powerpc git tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Date: Mon, 07 Nov 2011 10:29:10 +1100
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi folks !

I've moved the powerpc git tree back to kernel.org. The URL should be
back to normal for users:

git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git

I've only uploaded the next and merge branches for now (merge is stale
btw, it's just there to avoid breaking scripts).

Note: Ignore the "linux-powerpc.git" tree that's next to that one, it's
a mistake and I haven't manage to delete it just yet...

Cheers,
Ben.
