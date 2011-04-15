Return-Path: <nacc@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E29D3B7003
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 03:27:36 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3FH7O0I002632
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 13:07:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3FHRSws1191992
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 13:27:28 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p3FHRRCX005160
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 14:27:28 -0300
Date: Fri, 15 Apr 2011 10:27:16 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Steve Wise <swise@opengridcomputing.com>
Subject: Re: [PATCH] cxgb4: use pgprot_writecombine() on powerpc
Message-ID: <20110415172716.GA5881@us.ibm.com>
References: <1300134971-16752-1-git-send-email-nacc@us.ibm.com>
	<4D7E7FCE.3000703@opengridcomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D7E7FCE.3000703@opengridcomputing.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 14.03.2011 [15:51:26 -0500], Steve Wise wrote:
> On 03/14/2011 03:36 PM, Nishanth Aravamudan wrote:
> >Commit fe3cc0d99de6a9bf99b6c279a8afb5833888c1f7 ("powerpc: Add
> >pgprot_writecombine") in benh's tree exposes the pgprot_writecombine()
> >API to drivers on powerpc. cxgb4 has an open-coded version of the same,
> >so use the common API now that it's available.
> >
> >Signed-off-by: Nishanth Aravamudan<nacc@us.ibm.com>
> >Cc: Steve Wise<swise@opengridcomputing.com>
> >Cc: Anton Blanchard<anton@samba.org>
> >
> >---
> >
> >Given that this depends on a patch in Ben's tree, should this go in via
> >the powerpc tree? Presuming Steve acks it, of course.
> >
> >  drivers/infiniband/hw/cxgb4/t4.h |    5 +----
> >  1 files changed, 1 insertions(+), 4 deletions(-)
> >
> 
> Acked-by: Steve Wise <swise@opengridcomputing.com>
> 
> I suppose it should go into the same tree with the commit that adds this function.

Ben, I don't think this is in your tree yet, will you be taking it?

Thanks,
Nish
