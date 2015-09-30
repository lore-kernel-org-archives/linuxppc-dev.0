Return-Path: <hch@lst.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D9E331A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 01:09:34 +1000 (AEST)
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 74709140D24
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2015 01:09:33 +1000 (AEST)
Date: Wed, 30 Sep 2015 17:03:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, hch@lst.de, JBottomley@Odin.com,
 snitzer@redhat.com, hare@suse.de, martin.petersen@oracle.com
Subject: Re: [PATCH] powerpc/configs: Re-enable CONFIG_SCSI_DH
Message-ID: <20150930150329.GA26299@lst.de>
References: <1443522908-25523-1-git-send-email-mpe@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1443522908-25523-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 29, 2015 at 08:35:08PM +1000, Michael Ellerman wrote:
> Commit 086b91d052eb ("scsi_dh: integrate into the core SCSI code")
> changed CONFIG_SCSI_DH from tristate to bool.
> 
> Our defconfigs have CONFIG_SCSI_DH=m, which the kconfig machinery warns
> us is invalid, but instead of converting it to =y it leaves it unset.
> This means we loose the CONFIG_SCSI_DH code and everything that depends
> on it.
> 
> So convert the values in the defconfigs to =y.
> 
> Fixes: 086b91d052eb ("scsi_dh: integrate into the core SCSI code")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
