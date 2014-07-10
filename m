Return-Path: <agraf@suse.de>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 461851A016B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Jul 2014 20:16:17 +1000 (EST)
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A6376140146
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Jul 2014 20:16:16 +1000 (EST)
Message-ID: <53BE67EA.8000206@suse.de>
Date: Thu, 10 Jul 2014 12:16:10 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/kvm: Create proper names for the kvm_host_state
 PMU fields
References: <1404984871-15145-1-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1404984871-15145-1-git-send-email-mpe@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 10.07.14 11:34, Michael Ellerman wrote:
> We have two arrays in kvm_host_state that contain register values for
> the PMU. Currently we only create an asm-offsets symbol for the base of
> the arrays, and do the array offset in the assembly code.
>
> Creating an asm-offsets symbol for each field individually makes the
> code much nicer to read, particularly for the MMCRx/SIxR/SDAR fields, and
> might have helped us notice the recent double restore bug we had in this
> code.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Alexander Graf <agraf@suse.de>

I still think this whole code path should just be C though.


Alex
