Return-Path: <nacc@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 432B5B70EF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Nov 2010 06:46:31 +1100 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id oATJi7Wp020343
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Nov 2010 12:44:07 -0700
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oATJkOiu214802
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Nov 2010 12:46:24 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oATJkNC8015370
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Nov 2010 12:46:23 -0700
Date: Mon, 29 Nov 2010 11:46:20 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/15] ppc/vio: ensure dma_coherent_mask is set
Message-ID: <20101129194620.GA2998@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-16-git-send-email-nacc@us.ibm.com>
	<1290992577.32570.216.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290992577.32570.216.camel@pasglop>
Cc: Brian King <brking@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.ozlabs.org, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On 29.11.2010 [12:02:57 +1100], Benjamin Herrenschmidt wrote:
> On Wed, 2010-09-15 at 11:05 -0700, Nishanth Aravamudan wrote:
> > Without this change drivers, such as ibmvscsi, fail to load with the
> > previous change.
> > ---
> 
> So you broke bisection... fold the patch instead or invert them

Thanks for the review. I resent this series on 10/18 and it had the
patches folded together.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
