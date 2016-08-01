Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s37kj3bFrzDqRq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 04:53:01 +1000 (AEST)
Received: by mail-wm0-x242.google.com with SMTP id i5so27437916wmg.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 01 Aug 2016 11:53:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Subject: Re: [PATCH v2 1/1] KVM: PPC: Introduce KVM_CAP_PPC_HTM
To: Michael Ellerman <mpe@ellerman.id.au>,
 Sam Bobroff <sam.bobroff@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <7286403003b30fc87740f1c1d6cb67d8f8eaafd7.1468986094.git.sam.bobroff@au1.ibm.com>
 <20534.8713825972$1468993677@news.gmane.org>
 <ee83aaeb-40cf-4b46-4ae0-bb4265a0e610@redhat.com>
Cc: kvm@vger.kernel.org, aik@ozlabs.ru, agraf@suse.de,
 kvm-ppc@vger.kernel.org, qemu-devel@nongnu.org, paulus@samba.org,
 david@gibson.dropbear.id.au, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
 <rkrcmar@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <66a3fbaa-8f0c-870d-063c-00c2340c06b5@redhat.com>
Date: Mon, 1 Aug 2016 20:52:52 +0200
MIME-Version: 1.0
In-Reply-To: <ee83aaeb-40cf-4b46-4ae0-bb4265a0e610@redhat.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 20/07/2016 08:30, Paolo Bonzini wrote:
> In particular this patch would indeed have a conflict, because you have
> 
> +#define KVM_CAP_PPC_HTM 129
> 
> but cap numbers 129 and 130 are already taken.  So whoever applies it
> should bump the number to 131.

Applied now, it's 132.

Paolo
