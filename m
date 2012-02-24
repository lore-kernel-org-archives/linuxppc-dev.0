Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id D6F48B6EEE
 for <linuxppc-dev@ozlabs.org>; Sat, 25 Feb 2012 00:59:35 +1100 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 28703-07 for <linuxppc-dev@ozlabs.org>;
 Fri, 24 Feb 2012 13:52:09 +0000 (GMT)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 20/21] Introduce struct eeh_stats for EEH
Date: Fri, 24 Feb 2012 13:51:32 -0000
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B6E79@saturn3.aculab.com>
In-Reply-To: <1330076298-7006-21-git-send-email-shangw@linux.vnet.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Gavin Shan" <shangw@linux.vnet.ibm.com>,
	<linuxppc-dev@ozlabs.org>
Cc: kernel.crashing.org@shangw
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> +/*
> + * The struct is used to maintain the EEH global statistic
> + * information. Besides, the EEH global statistics will be
> + * exported to user space through procfs
> + */
> +struct eeh_stats {
> +	unsigned long no_device;	/* PCI device not found
*/
> +	unsigned long no_dn;		/* OF node not found
*/
> +	unsigned long no_cfg_addr;	/* Config address not  found
*/
> +	unsigned long ignored_check;	/* EEH check skipped
*/
> +	unsigned long total_mmio_ffs;	/* Total EEH checks
*/
> +	unsigned long false_positives;	/* Unnecessary EEH checks
*/
> +	unsigned long slot_resets;	/* PE reset
*/
> +};

Why 'unsigned long', surely either 'unsigned int'
or a fixed-width type.

	David
