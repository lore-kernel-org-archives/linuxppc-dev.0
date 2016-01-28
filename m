Return-Path: <dsahern@gmail.com>
Received: from mail-ob0-x233.google.com (mail-ob0-x233.google.com
 [IPv6:2607:f8b0:4003:c01::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B553C1A1A01
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 04:22:06 +1100 (AEDT)
Received: by mail-ob0-x233.google.com with SMTP id wb13so8180262obb.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 09:22:06 -0800 (PST)
Subject: Re: [PATCH v11 2/4] perf,kvm/{x86,s390}: Remove const from
 kvm_events_tp
To: Hemant Kumar <hemant@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1453962787-15376-1-git-send-email-hemant@linux.vnet.ibm.com>
 <1453962787-15376-2-git-send-email-hemant@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, mingo@kernel.org,
 mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org, scottwood@freescale.com,
 yarygin@linux.vnet.ibm.com
From: David Ahern <dsahern@gmail.com>
Message-ID: <56AA4E3B.4050606@gmail.com>
Date: Thu, 28 Jan 2016 10:22:03 -0700
MIME-Version: 1.0
In-Reply-To: <1453962787-15376-2-git-send-email-hemant@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 1/27/16 11:33 PM, Hemant Kumar wrote:
> This patch removes the "const" qualifier from kvm_events_tp declaration
> to account for the fact that some architectures may need to update this
> variable dynamically. For instance, powerpc will need to update this
> variable dynamically depending on the machine type.
>
> Signed-off-by: Hemant Kumar<hemant@linux.vnet.ibm.com>
> ---

Acked-by: David Ahern <dsahern@gmail.com>
