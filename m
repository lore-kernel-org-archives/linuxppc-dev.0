Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6A4171A0166
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2015 20:11:55 +1100 (AEDT)
Message-ID: <1446541914.23081.3.camel@ellerman.id.au>
Subject: Re: [PATCH] cxl: Fix reference count on struct pid when attaching
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, Ian Munsie
 <imunsie@au1.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Frederic Barrat
 <frederic.barrat@fr.ibm.com>
Date: Tue, 03 Nov 2015 20:11:54 +1100
In-Reply-To: <56386D88.3020206@linux.vnet.ibm.com>
References: <1446122343-26068-1-git-send-email-frederic.barrat@fr.ibm.com>
 <1446425625.27828.0.camel@ellerman.id.au>
 <1446507545-sup-9915@delenn.ozlabs.ibm.com>
 <56386D88.3020206@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-11-03 at 09:17 +0100, Frederic Barrat wrote:
> Le 03/11/2015 00:48, Ian Munsie a écrit :
> > 
> > Looks like we managed to introduce the same bug twice (d'oh!), so we
> > should probably split this into two separate patches:
> > 
> > The bug in file.c has existed forever so the fix for that should go to
> > stable for 3.18+
> > 
> > The bug in api.c will only need to go in for 4.3 since that is the
> > release where cxlflash was merged and there weren't any users of that
> > code before that.
> 
> So I'm dropping this patch and will resubmit as 2 separate patches.

Yes thanks.
