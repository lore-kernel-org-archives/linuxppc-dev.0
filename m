Return-Path: <linas@austin.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4AEC0DDEC6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 04:59:50 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2LHxlE9013105
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 13:59:47 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2LHxkwv064354
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 11:59:46 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2LHxkhk000894
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 11:59:46 -0600
Date: Wed, 21 Mar 2007 12:59:46 -0500
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 2/11] ppc64: EEH: Add clarifying messages.
Message-ID: <20070321175946.GY5151@austin.ibm.com>
References: <20070319194349.GT5151@austin.ibm.com>
	<20070319195204.GB11532@austin.ibm.com>
	<46002764.70900@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46002764.70900@linux.vnet.ibm.com>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 01:26:44PM -0500, Brian King wrote:
> Linas Vepstas wrote:
> > There are multiple code patchs tht resuls in a "permanent
> > failure"; when examining rare events, it can be hard to see 
> > which was taken. This patch adds printk's to assist.
> 
> Should these printk's be logging the location of the failing device/slot?

They all branch to a common printk which does do this. The problem I had
was that I couldn't tell which branch had taken me there.

--linas
