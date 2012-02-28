Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp06.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4AE03B6FA4
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 12:14:03 +1100 (EST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 06:44:01 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S1DwA62191578
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 06:43:58 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S1DvRo027151
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 12:13:57 +1100
Date: Tue, 28 Feb 2012 09:13:54 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 14/21] Introduce EEH device
Message-ID: <20120228011354.GA3457@shangw>
References: <1330076298-7006-1-git-send-email-shangw@linux.vnet.ibm.com>
 <1330076298-7006-15-git-send-email-shangw@linux.vnet.ibm.com>
 <20120224234610.922da1a3a2523ee5b6319390@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120224234610.922da1a3a2523ee5b6319390@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
Reply-To: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hi Gavin,
> 
> On Fri, 24 Feb 2012 17:38:11 +0800 Gavin Shan <shangw@linux.vnet.ibm.com> wrote:
> >
> > +#define EEH_DEV_TO_OF_NODE(edev)	(edev->dn)
> > +#define EEH_DEV_TO_PCI_DEV(edev)	(edev->pdev)
> > +#define OF_NODE_TO_EEH_DEV(dn)		((struct eeh_dev *)(dn->edev))
> > +#define PCI_DEV_TO_EEH_DEV(pdev)	((struct eeh_dev *)(pdev->dev.archdata.edev))
> 
> You need to put parentheses around the use of macro arguments ... or,
> even better, make these into "static inline" accessor functions (with
> lower case names).
> 

Thanks for your comments, Stephen. I'd like to make "static inline"
functions for them in next revision ;-)

Thanks,
Gavin

> -- 
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
