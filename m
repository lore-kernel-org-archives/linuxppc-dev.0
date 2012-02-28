Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 57E60B6EEC
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 12:23:03 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Tue, 28 Feb 2012 06:53:00 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1S1Mv4O3014862
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 06:52:57 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1S1MuFQ015486
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2012 12:22:56 +1100
Date: Tue, 28 Feb 2012 09:22:55 +0800
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 20/21] Introduce struct eeh_stats for EEH
Message-ID: <20120228012255.GC3457@shangw>
References: <1330076298-7006-21-git-send-email-shangw@linux.vnet.ibm.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B6E79@saturn3.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B6E79@saturn3.aculab.com>
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

>  
> > +/*
> > + * The struct is used to maintain the EEH global statistic
> > + * information. Besides, the EEH global statistics will be
> > + * exported to user space through procfs
> > + */
> > +struct eeh_stats {
> > +	unsigned long no_device;	/* PCI device not found
> */
> > +	unsigned long no_dn;		/* OF node not found
> */
> > +	unsigned long no_cfg_addr;	/* Config address not  found
> */
> > +	unsigned long ignored_check;	/* EEH check skipped
> */
> > +	unsigned long total_mmio_ffs;	/* Total EEH checks
> */
> > +	unsigned long false_positives;	/* Unnecessary EEH checks
> */
> > +	unsigned long slot_resets;	/* PE reset
> */
> > +};
> 
> Why 'unsigned long', surely either 'unsigned int'
> or a fixed-width type.
> 

Thanks, David. Could you pls give more information on
how the fixed-width types benefits us?

Thanks,
Gavin
 
> 	David
> 
> 
