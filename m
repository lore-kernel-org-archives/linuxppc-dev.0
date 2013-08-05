Return-Path: <B07421@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 718A92C0082
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 02:31:05 +1000 (EST)
Message-ID: <1375720252.13074.12.camel@snotra.buserror.net>
Subject: Re: [PATCH 6/6 v2] kvm: powerpc: use caching attributes as per
 linux pte
From: Scott Wood <scottwood@freescale.com>
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Date: Mon, 5 Aug 2013 11:30:52 -0500
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FE9@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-7-git-send-email-Bharat.Bhushan@freescale.com>
 <20130802233452.GA27636@home.buserror.net>
 <6A3DF150A5B70D4F9B66A25E3F7C888D070F8FE9@039-SN2MPN1-012.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-02 at 22:11 -0500, Bhushan Bharat-R65777 wrote:
> > How does wimg get set in the pfnmap case?
> 
> Pfnmap is not kernel managed pages, right? So should we set I+G there ?

It could depend on ppc_md.phys_mem_access_prot().  Can't you pull it
from the PTE regardless of pfnmap?

-Scott
