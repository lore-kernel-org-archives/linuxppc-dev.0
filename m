Return-Path: <jmorris@namei.org>
Received: from tundra.namei.org (tundra.namei.org [65.99.196.166])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 64CAB2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Sep 2012 13:58:53 +1000 (EST)
Date: Wed, 12 Sep 2012 13:16:25 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Kent Yoder <key@linux.vnet.ibm.com>
Subject: Re: [PATCH V3 1/3] drivers/char/tpm: Add new device driver to support
 IBM vTPM
In-Reply-To: <20120907173809.GA19704@linux.vnet.ibm.com>
Message-ID: <alpine.LRH.2.02.1209121316030.4482@tundra.namei.org>
References: <1344987282.4430.26.camel@footlong>
 <1345670263.25124.7.camel@footlong>
 <20120822214217.GB13519@linux.vnet.ibm.com>
 <1346816407.2257.37.camel@pasglop>
 <20120905154644.GA14925@linux.vnet.ibm.com>
 <1346879505.19098.3.camel@pasglop>
 <20120907173809.GA19704@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, Ashley Lai <adlai@linux.vnet.ibm.com>,
 linux-security-module@vger.kernel.org, tpmdd-devel@lists.sourceforge.net,
 adlai@us.ibm.com, rcj@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 7 Sep 2012, Kent Yoder wrote:

> > >   James did accept my pull request, so these are already in
> > > security-next...
> > 
> > For the driver itself, it's not a big issue (though I did found issue
> > while reviewing it so it will need another round of updates). For the
> > code that changes arch/powerpc, especially prom_init.c, that stuff must
> > at the very least be acked by me (or the acting powerpc person if I'm
> > away) if it's going to go via a different tree.
> 
>   Sorry about that.  Hopefully there won't be any changes there and we
> can amend with your ack.
> 
>   As for the driver updates, I'd hate to see everyone else's code in the
> pull request get delayed yet again.  James, will it be ok to apply the
> update on top of security-next?

I guess?

-- 
James Morris
<jmorris@namei.org>
