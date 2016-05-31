Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJqYr1K5gzDqbD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 20:32:32 +1000 (AEST)
Message-ID: <1464690745.23025.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pseries: Add POWER8NVL support to
 ibm,client-architecture-support call
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thomas Huth <thuth@redhat.com>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, kvm-ppc@vger.kernel.org
Date: Tue, 31 May 2016 20:32:25 +1000
In-Reply-To: <574D6549.3050903@redhat.com>
References: <1464673877-30659-1-git-send-email-thuth@redhat.com>
 <1464689047.23025.1.camel@ellerman.id.au> <574D6549.3050903@redhat.com>
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

On Tue, 2016-05-31 at 12:19 +0200, Thomas Huth wrote:
> On 31.05.2016 12:04, Michael Ellerman wrote:
> > On Tue, 2016-05-31 at 07:51 +0200, Thomas Huth wrote:
> > > If we do not provide the PVR for POWER8NVL, a guest on this
> > > system currently ends up in PowerISA 2.06 compatibility mode on
> > > KVM, since QEMU does not provide a generic PowerISA 2.07 mode yet.
> > > So some new instructions from POWER8 (like "mtvsrd") get disabled
> > > for the guest, resulting in crashes when using code compiled
> > > explicitly for POWER8 (e.g. with the "-mcpu=power8" option of GCC).
> > > 
> > > Signed-off-by: Thomas Huth <thuth@redhat.com>
> > 
> > So this should say:
> > 
> >   Fixes: ddee09c099c3 ("powerpc: Add PVR for POWER8NVL processor")
> > 
> > And therefore:
> > 
> >   Cc: stable@vger.kernel.org # v4.0+
> > 
> > Am I right?
> 
> Right. (At least for virtualized systems ... for bare-metal systems,
> that original patch was enough). So shall I resubmit my patch with these
> two lines, or could you add them when you pick this patch up?

Thanks, I'll add them here.

cheers
