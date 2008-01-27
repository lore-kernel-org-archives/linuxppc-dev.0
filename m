Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (E23SMTP01.au.ibm.com [202.81.18.162])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp01.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 08C86DDDEB
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 02:38:13 +1100 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp01.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0RFd5Ps030582
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 02:39:05 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0RFfoeU290938
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 02:41:50 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0RFcEtX009820
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jan 2008 02:38:14 +1100
Date: Sun, 27 Jan 2008 20:31:47 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC (Take 2)
Message-ID: <20080127150147.GA10914@balbir.in.ibm.com>
References: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
	<1200634493.7806.0.camel@concordia.ozlabs.ibm.com>
	<1200635099.7806.3.camel@concordia.ozlabs.ibm.com>
	<20080126071339.GA25328@balbir.in.ibm.com>
	<18332.28991.658933.763115@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <18332.28991.658933.763115@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Paul Mackerras <paulus@samba.org> [2008-01-27 22:55:43]:

> Balbir Singh writes:
> 
> > Here's a better and more complete fix for the problem. Could you
> > please see if it works for you? I tested it on a real NUMA box and it
> > seemed to work fine there.
> 
> There are a couple of other changes in behaviour that your patch
> introduces, and I'd like to understand them better before taking the
> patch.  First, with your patch we don't set nodes online if they end
> up having no memory in them because of the memory limit, whereas
> previously we did.  Secondly, in the case where we don't have NUMA
> information, we now set node 0 online after adding each LMB, whereas
> previously we only set it online once.
> 
> If in fact these changes are benign, then your patch description
> should mention them and explain why they are benign.
>

Yes, they are. I'll try and justify the changes with a good detailed
changelog. If people prefer it, I can hide fake NUMA nodes under a
config option, so that it does not come enabled by default.

Thanks for keeping me honest.
 
> Paul.
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
