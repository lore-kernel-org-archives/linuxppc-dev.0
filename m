Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2EEDE2C009A
 for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2012 06:33:43 +1100 (EST)
Message-ID: <1350416012.4678.54.camel@pasglop>
Subject: Re: [PATCH] kvm/powerpc: Handle errors in secondary thread grabbing
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexander Graf <agraf@suse.de>
Date: Wed, 17 Oct 2012 06:33:32 +1100
In-Reply-To: <1350367235.32704.1.camel@concordia>
References: <1350346550-32539-1-git-send-email-michael@ellerman.id.au>
 <20121016031352.GK1218@drongo> <1350367235.32704.1.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>, agraf@suse.de,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-10-16 at 17:00 +1100, Michael Ellerman wrote:
> > Thanks for looking at this - but in fact this is fixed by my patch
> > entitled "KVM: PPC: Book3S HV: Fix some races in starting secondary
> > threads" submitted back on August 28.
> 
> OK thanks. It seems that patch didn't make 3.7 ?
> 
> I don't see it in kvm-ppc-next either.

Alex, WTF ?

Ben.
