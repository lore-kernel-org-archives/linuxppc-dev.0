Return-Path: <joel.stan@gmail.com>
Received: from mail-vc0-f175.google.com (mail-vc0-f175.google.com
 [209.85.220.175])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id CF66814011F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Apr 2014 14:03:19 +1000 (EST)
Received: by mail-vc0-f175.google.com with SMTP id lh14so2262403vcb.34
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 21:03:14 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <1398303165-6576-7-git-send-email-mikey@neuling.org>
References: <1398303165-6576-1-git-send-email-mikey@neuling.org>
 <1398303165-6576-7-git-send-email-mikey@neuling.org>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 24 Apr 2014 13:32:54 +0930
Message-ID: <CACPK8Xc6RqXCSR0BvHT=jZbUcWEEYZ50n4r1vQkUyu=NPfpFew@mail.gmail.com>
Subject: Re: [PATCH 6/6] powerpc/powernv: Add support for POWER8 split core on
 powernv
To: Michael Neuling <mikey@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mikey,

On Thu, Apr 24, 2014 at 11:02 AM, Michael Neuling <mikey@neuling.org> wrote:
> +static DEVICE_ATTR(subcores_per_core, 0600,
> +               show_subcores_per_core, store_subcores_per_core);

Can we make this 644, so users can query the state of the system
without being root? This is useful for tools like ppc64_cpu --info.

Cheers,

Joel
