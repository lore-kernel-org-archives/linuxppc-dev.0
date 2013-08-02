Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 91CBC2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 10:45:21 +1000 (EST)
Message-ID: <1375485408.15999.67.camel@pasglop>
Subject: Re: [PATCH 5/6 v2] kvm: powerpc: booke: Add linux pte lookup like
 booke3s
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Sat, 03 Aug 2013 09:16:48 +1000
In-Reply-To: <1375484319.26902.4.camel@snotra.buserror.net>
References: <1375355558-19187-1-git-send-email-Bharat.Bhushan@freescale.com>
 <1375355558-19187-6-git-send-email-Bharat.Bhushan@freescale.com>
 <1375484319.26902.4.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, agraf@suse.de, kvm-ppc@vger.kernel.org,
 Bharat Bhushan <Bharat.Bhushan@freescale.com>,
 Bharat Bhushan <r65777@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-02 at 17:58 -0500, Scott Wood wrote:
> 
> What about 64-bit PTEs on 32-bit kernels?
> 
> In any case, this code does not belong in KVM.  It should be in the
> main
> PPC mm code, even if KVM is the only user.

Also don't we do similar things in BookS KVM ? At the very least that
sutff should become common. And yes, I agree, it should probably also
move to pgtable*

Cheers,
Ben.
