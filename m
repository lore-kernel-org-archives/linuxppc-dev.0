Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe005.messaging.microsoft.com
 [65.55.88.15]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7ACEAB6FC2
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Feb 2012 04:15:42 +1100 (EST)
Message-ID: <4F39452B.2030202@freescale.com>
Date: Mon, 13 Feb 2012 11:15:23 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Liu Yu-B13201 <B13201@freescale.com>
Subject: Re: [PATCH v3 1/3] KVM: PPC: epapr: Factor out the epapr init
References: <1328868141-17364-1-git-send-email-yu.liu@freescale.com>
 <4F356477.7010809@freescale.com>
 <4CA99838F21AB847ACC344051E231709057158DE@039-SN2MPN1-022.039d.mgd.msft.net>
In-Reply-To: <4CA99838F21AB847ACC344051E231709057158DE@039-SN2MPN1-022.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Wood Scott-B07421 <B07421@freescale.com>, "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/12/2012 11:47 PM, Liu Yu-B13201 wrote:
> 
> 
>> -----Original Message-----
>> From: Wood Scott-B07421
>> Sent: Saturday, February 11, 2012 2:40 AM
>> To: Liu Yu-B13201
>> Cc: agraf@suse.de; kvm-ppc@vger.kernel.org; kvm@vger.kernel.org;
>> linuxppc-dev@ozlabs.org; Wood Scott-B07421
>> Subject: Re: [PATCH v3 1/3] KVM: PPC: epapr: Factor out the epapr init
>>
>> Why are you still doing the patching inside kvm.c?
>>
> 
> Do you mean we should move kvm_hypercall_start() into epapr bit?

Yes.  This is an ePAPR mechanism; KVM just happens to be a user of it.

We should also update arch/powerpc/include/asm/epapr_hcalls.h to use
this mechanism.

-Scott
