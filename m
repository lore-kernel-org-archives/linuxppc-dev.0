Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 444C12C0088
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2012 01:02:14 +1000 (EST)
Message-ID: <5051F56E.6010409@suse.de>
Date: Thu, 13 Sep 2012 17:02:06 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>
Subject: Re: [PATCH] KVM: PPC: bookehv: Allow duplicate calls of DO_KVM macro
References: <1347455894-30044-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1347455894-30044-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/12/2012 03:18 PM, Mihai Caraman wrote:
> The current form of DO_KVM macro restricts its use to one call per input
> parameter set. This is caused by kvmppc_resume_\intno\()_\srr1 symbol
> definition.
> Duplicate calls of DO_KVM are required by distinct implementations of
> exeption handlers which are delegated at runtime. Use a rare label number
> to avoid conflicts with the calling contexts.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Thanks, applied to kvm-ppc-next.


Alex
