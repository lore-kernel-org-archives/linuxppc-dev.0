Return-Path: <gsi@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B37782C009F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 07:01:45 +1100 (EST)
Date: Mon, 11 Nov 2013 21:01:22 +0100
From: Gerhard Sittig <gsi@denx.de>
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH RFC v5 1/5] dma: mpc512x: reorder mpc8308 specific
 instructions
Message-ID: <20131111200122.GQ17929@book.gsilab.sittig.org>
References: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
 <1383290374-17484-2-git-send-email-a13xp0p0v88@gmail.com>
 <20131101110418.1158b999@crub>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20131101110418.1158b999@crub>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Alexander Popov <a13xp0p0v88@gmail.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[ dropping devicetree@vger from CC ]

On Fri, Nov 01, 2013 at 11:04 +0100, Anatolij Gustschin wrote:
> 
> On Fri,  1 Nov 2013 11:19:30 +0400
> Alexander Popov <a13xp0p0v88@gmail.com> wrote:
> 
> > Concentrate the specific code for MPC8308 in the 'if' branch
> > and handle MPC512x in the 'else' branch.
> > This modification only reorders instructions but doesn't change behaviour.
> > 
> > Signed-off-by: Alexander Popov <a13xp0p0v88@gmail.com>
> > ---
> >  drivers/dma/mpc512x_dma.c | 42 +++++++++++++++++++++++++-----------------
> >  1 file changed, 25 insertions(+), 17 deletions(-)
> 
> Acked-by: Anatolij Gustschin <agust@denx.de>

I feel that this patch has become stable and can be taken,
regardless of the pending review of the other parts in the series.


virtually yours
Gerhard Sittig
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr. 5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
