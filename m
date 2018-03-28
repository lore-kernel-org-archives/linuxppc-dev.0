Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0023.hostedemail.com
 [216.40.44.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40BKcN6cWtzF2Dr
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 07:44:20 +1100 (AEDT)
Message-ID: <1522269853.12357.135.camel@perches.com>
Subject: Re: [PATCH v4 14/16] powerpc: Use generic free_initrd_mem.
From: Joe Perches <joe@perches.com>
To: Shea Levy <shea@shealevy.com>, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko
 <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>, Andrew Morton
 <akpm@linux-foundation.org>, Dan Williams <dan.j.williams@intel.com>,
 Christophe Leroy <christophe.leroy@c-s.fr>, Oliver O'Halloran
 <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Date: Wed, 28 Mar 2018 13:44:13 -0700
In-Reply-To: <20180328203659.18692-15-shea@shealevy.com>
References: <20180328152714.6103-1-shea@shealevy.com>
 <20180328203659.18692-1-shea@shealevy.com>
 <20180328203659.18692-15-shea@shealevy.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-03-28 at 16:36 -0400, Shea Levy wrote:
> Signed-off-by: Shea Levy <shea@shealevy.com>

Most people seem to want some form of commit message
and not just your sign-off.

And btw:

It seems you used get_maintainer to determine who to
send these patches to.

I suggest you add --nogit and --nogit-fallback to the
get_maintainer command line you use to avoid sending
these patches to people like me that have done drive-by
cleanup work on these files.
