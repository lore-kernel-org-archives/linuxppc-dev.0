Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 609CC1A01A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Jul 2014 14:46:28 +1000 (EST)
Message-ID: <1405053987.16256.1.camel@concordia>
Subject: Re: [PATCH] powerpc/kvm: Create proper names for the kvm_host_state
 PMU fields
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexander Graf <agraf@suse.de>
Date: Fri, 11 Jul 2014 14:46:27 +1000
In-Reply-To: <53BE67EA.8000206@suse.de>
References: <1404984871-15145-1-git-send-email-mpe@ellerman.id.au>
 <53BE67EA.8000206@suse.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-10 at 12:16 +0200, Alexander Graf wrote:
> On 10.07.14 11:34, Michael Ellerman wrote:
> > We have two arrays in kvm_host_state that contain register values for
> > the PMU. Currently we only create an asm-offsets symbol for the base of
> > the arrays, and do the array offset in the assembly code.
> >
> > Creating an asm-offsets symbol for each field individually makes the
> > code much nicer to read, particularly for the MMCRx/SIxR/SDAR fields, and
> > might have helped us notice the recent double restore bug we had in this
> > code.
> >
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Acked-by: Alexander Graf <agraf@suse.de>

Thanks.

> I still think this whole code path should just be C though.

Yeah it probably should.

cheers
