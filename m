Return-Path: <adlai@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 17D0F2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2012 00:44:29 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <adlai@linux.vnet.ibm.com>;
 Thu, 27 Sep 2012 10:44:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q8REiLev087488
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 10:44:21 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q8REiKqL000534
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2012 11:44:20 -0300
Message-ID: <1348757203.13546.4.camel@footlong>
Subject: Re: [PATCH 1/1] drivers/char/tpm: remove tasklet and cleanup
From: Ashley Lai <adlai@linux.vnet.ibm.com>
To: key@linux.vnet.ibm.com
Date: Thu, 27 Sep 2012 09:46:43 -0500
In-Reply-To: <20120926135513.GA8251@ennui.austin.ibm.com>
References: <1345670263.25124.7.camel@footlong>
 <1347472190.27058.5.camel@footlong>
 <alpine.LRH.2.02.1209241225230.678@tundra.namei.org>
 <20120924141041.GA2741@ennui.austin.ibm.com>
 <20120924154821.GA16007@ennui.austin.ibm.com>
 <20120926135513.GA8251@ennui.austin.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: James Morris <jmorris@namei.org>, linux-kernel@vger.kernel.org,
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

On Wed, 2012-09-26 at 08:55 -0500, key@linux.vnet.ibm.com wrote:
> On Mon, Sep 24, 2012 at 10:48:21AM -0500, key@linux.vnet.ibm.com wrote:
> > On Mon, Sep 24, 2012 at 09:10:41AM -0500, key@linux.vnet.ibm.com wrote:
> > > On Mon, Sep 24, 2012 at 12:26:05PM +1000, James Morris wrote:
> > > > On Wed, 12 Sep 2012, Ashley Lai wrote:
> > > > 
> > > > > This patch removed the tasklet and moved the wait queue into the
> > > > > private structure.  It also cleaned up the response CRQ path.
> > > > > 
> > > > > Signed-off-by: Ashley Lai <adlai@us.ibm.com>
> > > > 
> > > > 
> > > > Kent: any comment on this?  You should probably push this to me via your 
> > > > tree.
> > > 
> > >   Oh, I thought we were waiting on Ben. This looks good to me, I'll get
> > > this to you today.
> > 
> >   Ashley tells me Ben's review is in the works, so I'll send once we
> > have it.
> 
>   Ben - any status here?
> 
> Kent

Hi Ben,

Would you review the patch before the weekend?  If you are busy and not
able to review the patch this week, we will pull the patch into James's
tree next week.  I can resolve any additional comments you may have in a
different patch.

Thanks,
--Ashley Lai

> 
> > 
> > Kent
> > 
> > > 
> > >   Kent
> > > 
> > 
> > --
> > To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
