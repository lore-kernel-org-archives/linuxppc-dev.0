Return-Path: <jthumshirn@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461B01A01CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 16:54:07 +1000 (AEST)
From: Johannes Thumshirn <jthumshirn@suse.de>
To: Ian Munsie <imunsie@au1.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH] cxl: Destroy cxl_adapter_idr on module_exit
References: <1436368476-30592-1-git-send-email-jthumshirn@suse.de>
 <1436406813-sup-5637@delenn.ozlabs.ibm.com>
Date: Thu, 09 Jul 2015 08:54:01 +0200
In-Reply-To: <1436406813-sup-5637@delenn.ozlabs.ibm.com> (Ian Munsie's message
 of "Thu, 09 Jul 2015 11:58:02 +1000")
Message-ID: <mqd615tu8hi.fsf@c203.arch.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ian Munsie <imunsie@au1.ibm.com> writes:

> Acked-by: Ian Munsie <imunsie@au1.ibm.com>
>
> We are probably also missing an idr_destroy(&afu->contexts_idr); in
> cxl_release_afu() as well if you wanted to send a patch for that.
>
> Cheers,
> -Ian
>

Correct, patch is going out today. Thanks for the hint.

--=20
Johannes Thumshirn                                       Storage
jthumshirn@suse.de                             +49 911 74053 689
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg
GF: F. Imend=C3=B6rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N=C3=BCrnberg)
