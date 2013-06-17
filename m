Return-Path: <paolo.bonzini@gmail.com>
Received: from mail-yh0-x236.google.com (mail-yh0-x236.google.com
 [IPv6:2607:f8b0:4002:c01::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 78FAC2C023D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Jun 2013 02:35:59 +1000 (EST)
Received: by mail-yh0-f54.google.com with SMTP id f73so1101751yha.41
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jun 2013 09:35:56 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
Message-ID: <51BF3AE6.3070805@redhat.com>
Date: Mon, 17 Jun 2013 18:35:50 +0200
From: Paolo Bonzini <pbonzini@redhat.com>
MIME-Version: 1.0
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Subject: Re: [PATCH 4/4] KVM: PPC: Add hugepage support for IOMMU in-kernel
 handling
References: <1370412673-1345-1-git-send-email-aik@ozlabs.ru>
 <1370412673-1345-5-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1370412673-1345-5-git-send-email-aik@ozlabs.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Il 05/06/2013 08:11, Alexey Kardashevskiy ha scritto:
> +/*
> + * The KVM guest can be backed with 16MB pages (qemu switch
> + * -mem-path /var/lib/hugetlbfs/global/pagesize-16MB/).

Nitpick: we try to avoid references to QEMU, so perhaps

s/qemu switch/for example, with QEMU you can use the command-line option/

Paolo
