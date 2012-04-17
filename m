Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8A0F1B700C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 10:03:31 +1000 (EST)
In-Reply-To: <1334617419.25353.15.camel@pasglop>
References: <1334607198-18694-1-git-send-email-grant.likely@secretlab.ca>
 <CACxGe6u7EUYqyZ_8tC8PFRHwS+xq7u9+fCJk+UFbrtrV-YJFvQ@mail.gmail.com>
 <1334617419.25353.15.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx
 interrupt controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OFAAF4BF26.BF8400B2-ONC12579E2.008226AC-C12579E3.00005051@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 17 Apr 2012 02:03:25 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> On Mon, 2012-04-16 at 14:13 -0600, Grant Likely wrote:
> > Ben, I can take these two patches via my irqdomain tree if you pref=
er.
>
> Let me give them a test run first.

Hi Ben

If you are going to test 8xx, could you revert e0908085fc2391c85b85fb81=
4ae1df377c8e0dcb,
powerpc/8xx:=A0Fix=A0regression=A0introduced=A0by=A0cache=A0coherency=A0=
rewrite ?

It should not be needed after I fixed up the 8xx TLB code and added a w=
orkaround
for buggy dcbX instructions.

 Jocke=
