Return-Path: <nacc@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D75410C7BD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Sep 2010 04:45:07 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o8FIj4hx026137
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:45:04 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o8FIj4th105992
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 14:45:04 -0400
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o8FIj2Y0014573
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Sep 2010 12:45:03 -0600
Date: Wed, 15 Sep 2010 11:44:56 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 15/15] ppc/vio: ensure dma_coherent_mask is set
Message-ID: <20100915184456.GC3683@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-16-git-send-email-nacc@us.ibm.com>
	<AANLkTi=K+KudbVAqZGA9fXXWq-vXirh9SuSTEHSh=kgC@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTi=K+KudbVAqZGA9fXXWq-vXirh9SuSTEHSh=kgC@mail.gmail.com>
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

On 15.09.2010 [12:37:58 -0600], Grant Likely wrote:
> On Wed, Sep 15, 2010 at 12:05 PM, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> > Without this change drivers, such as ibmvscsi, fail to load with the
> > previous change.
> 
> Shouldn't this patch be ordered before the previous change then to
> preserve bisectability?

You are probably right. I wasn't sure if I should fold it in or keep it
separate. I should have changed the order, though. Sorry about that!

> Also, patch descriptions should be explicit about what the "previous
> change" refers to.  Once this is committed, git log may very well
> insert other changes from other branches between this commit and
> whatever "previous change" refers to.

Yep -- what's the best way to make the reference? By subject from the
patch? Obviously I don't have the SHA1 with which the commit will go
upstream.

Thanks,
Nish

-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
