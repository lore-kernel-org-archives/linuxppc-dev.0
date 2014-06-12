Return-Path: <joel.stan@gmail.com>
Received: from mail-ve0-x22a.google.com (mail-ve0-x22a.google.com
 [IPv6:2607:f8b0:400c:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B860F1A02BA
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jun 2014 16:40:03 +1000 (EST)
Received: by mail-ve0-f170.google.com with SMTP id oz11so1326246veb.29
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jun 2014 23:39:59 -0700 (PDT)
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <53922FB8.6070408@linux.vnet.ibm.com>
References: <20140527105511.24309.74320.stgit@srivatsabhat.in.ibm.com>
 <20140528133143.GK14863@redhat.com> <538E2FF8.8060707@linux.vnet.ibm.com>
 <1401833365.3247.36.camel@pasglop> <5391B413.100@linux.vnet.ibm.com>
 <53922FB8.6070408@linux.vnet.ibm.com>
From: Joel Stanley <joel@jms.id.au>
Date: Thu, 12 Jun 2014 16:39:39 +1000
Message-ID: <CACPK8Xea+7rPHSCp51fVkX=GTmEwbV0T=JHDZ-XYt6RU96uyyg@mail.gmail.com>
Subject: Re: [PATCH] powerpc, kexec: Fix "Processor X is stuck" issue during
 kexec from ST mode
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ego@linux.vnet.ibm.com, matt@ozlabs.org,
 Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>, kexec@lists.infradead.org,
 linux-kernel@vger.kernel.org, suzuki@in.ibm.com, ebiederm@xmission.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Vivek Goyal <vgoyal@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Srivatsa,

On Sat, Jun 7, 2014 at 7:16 AM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> And with the following hunk added (which I had forgotten earlier), it worked just
> fine on powernv :-)

How are the patches coming along?

I just hung a machine here while attempting to kexec. It appears to
have onlined all of the secondary threads, and then hung here:

kexec: Waking offline cpu 1.
kvm: enabling virtualization on CPU1
kexec: Waking offline cpu 2.
kvm: enabling virtualization on CPU2
kexec: Waking offline cpu 3.
kvm: enabling virtualization on CPU3
kexec: Waking offline cpu 5.
kvm: enabling virtualization on CPU5
[...]
kvm: enabling virtualization on CPU63
kexec: waiting for cpu 1 (physical 1) to enter OPAL
kexec: waiting for cpu 2 (physical 2) to enter OPAL
kexec: waiting for cpu 3 (physical 3) to enter OPAL

I'm running benh's next branch as of thismorning, and SMT was off.

Could you please post your latest patches a series? I will test them here.

Cheers,

Joel
