Return-Path: <kyle@moffetthome.net>
Received: from mail-ey0-f170.google.com (mail-ey0-f170.google.com
	[209.85.215.170]) by ozlabs.org (Postfix) with ESMTP id DF53EB7118
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Aug 2010 15:24:37 +1000 (EST)
Received: by eyb6 with SMTP id 6so3023631eyb.15
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Aug 2010 22:24:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <B3286B71-599C-405E-847F-06B843A46449@suse.de>
References: <1282936005-17078-1-git-send-email-Kyle.D.Moffett@boeing.com>
	<B3286B71-599C-405E-847F-06B843A46449@suse.de>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Sat, 28 Aug 2010 01:24:14 -0400
Message-ID: <AANLkTimwBL42bAxa5okPeJ-y_oSCfp05_POxxRasZGFn@mail.gmail.com>
Subject: Re: [PATCH] powerpc/kvm/e500_tlb: Fix a minor copy-paste tracing bug
To: Alexander Graf <agraf@suse.de>
Content-Type: text/plain; charset=UTF-8
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Liu Yu <yu.liu@freescale.com>, linux-kernel@vger.kernel.org,
	Kyle Moffett <Kyle.D.Moffett@boeing.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 27, 2010 at 20:58, Alexander Graf <agraf@suse.de> wrote:
> On 27.08.2010, at 21:06, Kyle Moffett wrote:
>> The kvmppc_e500_stlbe_invalidate() function was trying to pass too many
>> parameters to trace_kvm_stlb_inval(). =C2=A0This appears to be a bad
>> copy-paste from a call to trace_kvm_stlb_write().
>
> Which kernel is this against? That trace point is already commented out i=
n my tree.

Oh, hm, I guess I haven't rebased this patch since 2.6.35-ish.  The
trace point seems to work correctly with the fixed arguments; if
you'll tell me which tree I should base it on I can easily resubmit.

Cheers,
Kyle Moffett
