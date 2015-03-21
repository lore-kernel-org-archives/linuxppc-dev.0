Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89BE31A0060
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Mar 2015 01:54:11 +1100 (AEDT)
Message-ID: <550D860D.6050506@suse.de>
Date: Sat, 21 Mar 2015 15:54:05 +0100
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Arseny Solokha <asolokha@kb.kras.ru>
Subject: Re: [PATCH v4 2/4] kvm/ppc/mpic: drop unused IRQ_testbit
References: <550C0760.50903@suse.de>
 <1426921004-27685-1-git-send-email-asolokha@kb.kras.ru>
In-Reply-To: <1426921004-27685-1-git-send-email-asolokha@kb.kras.ru>
Content-Type: text/plain; charset=windows-1252
Cc: linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 21.03.15 07:56, Arseny Solokha wrote:
> Drop unused static procedure which doesn't have callers within its
> translation unit. It had been already removed independently in QEMU[1]
> from the OpenPIC implementation borrowed by the kernel.
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2014-06/msg01812.html
> 
> v4: Fixed the comment regarding the origination of OpenPIC codebase
>     and CC'ed KVM mailing lists, as suggested by Alexander Graf.
> 
> v3: In patch 4/4, do not remove fsl_mpic_primary_get_version() from
>     arch/powerpc/sysdev/mpic.c because the patch by Jia Hongtao
>     ("powerpc/85xx: workaround for chips with MSI hardware errata") makes
>     use of it.
> 
> v2: Added a brief explanation to each patch description of why removed
>     functions are unused, as suggested by Michael Ellerman.
> 
> Signed-off-by: Arseny Solokha <asolokha@kb.kras.ru>

Thanks, applied to kvm-ppc-queue (for 4.1).


Alex
