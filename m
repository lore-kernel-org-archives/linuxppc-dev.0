Return-Path: <dsahern@gmail.com>
Received: from mail-oi0-x236.google.com (mail-oi0-x236.google.com
 [IPv6:2607:f8b0:4003:c06::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B96071A030F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jan 2016 04:21:28 +1100 (AEDT)
Received: by mail-oi0-x236.google.com with SMTP id k206so30940270oia.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jan 2016 09:21:28 -0800 (PST)
Subject: Re: [PATCH v11 1/4] perf,kvm/{x86,s390}: Remove dependency on
 uapi/kvm_perf.h
To: Hemant Kumar <hemant@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1453962787-15376-1-git-send-email-hemant@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, acme@kernel.org, mingo@kernel.org,
 mpe@ellerman.id.au, naveen.n.rao@linux.vnet.ibm.com,
 srikar@linux.vnet.ibm.com, paulus@samba.org, scottwood@freescale.com,
 yarygin@linux.vnet.ibm.com
From: David Ahern <dsahern@gmail.com>
Message-ID: <56AA4E14.6090105@gmail.com>
Date: Thu, 28 Jan 2016 10:21:24 -0700
MIME-Version: 1.0
In-Reply-To: <1453962787-15376-1-git-send-email-hemant@linux.vnet.ibm.com>
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
> Its better to remove the dependency on uapi/kvm_perf.h to allow dynamic
> discovery of kvm events (if its needed). To do this, some extern
> variables have been introduced with which we can keep the generic
> functions generic.
>
> Signed-off-by: Hemant Kumar<hemant@linux.vnet.ibm.com>
> Acked-by: Alexander Yarygin<yarygin@linux.vnet.ibm.com>

Acked-by: David Ahern <dsahern@gmail.com>
