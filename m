Return-Path: <key@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 094DE2C0089
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Sep 2012 01:47:30 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <key@linux.vnet.ibm.com>;
 Wed, 5 Sep 2012 11:47:25 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 8B02138C8067
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2012 11:47:11 -0400 (EDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q85FlAKi125490
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2012 11:47:10 -0400
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q85FkE7d029343
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Sep 2012 09:46:14 -0600
Date: Wed, 5 Sep 2012 10:46:44 -0500
From: Kent Yoder <key@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH V3 1/3] drivers/char/tpm: Add new device driver to
 support IBM vTPM
Message-ID: <20120905154644.GA14925@linux.vnet.ibm.com>
References: <1344987282.4430.26.camel@footlong>
 <1345670263.25124.7.camel@footlong>
 <20120822214217.GB13519@linux.vnet.ibm.com>
 <1346816407.2257.37.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1346816407.2257.37.camel@pasglop>
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

On Wed, Sep 05, 2012 at 01:40:07PM +1000, Benjamin Herrenschmidt wrote:
> On Wed, 2012-08-22 at 16:42 -0500, Kent Yoder wrote:
> > On Wed, Aug 22, 2012 at 04:17:43PM -0500, Ashley Lai wrote:
> > > This patch adds a new device driver to support IBM virtual TPM
> > > (vTPM) for PPC64.  IBM vTPM is supported through the adjunct
> > > partition with firmware release 740 or higher.  With vTPM
> > > support, each lpar is able to have its own vTPM without the
> > > physical TPM hardware.
> > > 
> > > This driver provides TPM functionalities by communicating with
> > > the vTPM adjunct partition through Hypervisor calls (Hcalls)
> > > and Command/Response Queue (CRQ) commands.
> > 
> >  Thanks Ashley, I'll include this in my next pull request to James.
> 
> Oh ? I was about to put it in the powerpc tree ... But yeah, I notice
> there's a change to tpm.h so it probably should be at least acked by the
> TPM folks. As for the subsequent patches, they are powerpc specific so I
> can add them, I don't think there's a strict dependency, is there ?

  James did accept my pull request, so these are already in
security-next...

Kent
