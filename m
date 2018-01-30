Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVqhx4L29zDr6N
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 13:15:13 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id w17so5993636pgv.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 18:15:13 -0800 (PST)
Date: Tue, 30 Jan 2018 10:15:07 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 13/26] KVM: PPC: Book3S PR: adds new
 kvmppc_copyto_vcpu_tm/kvmppc_copyfrom_vcpu_tm API for PR KVM.
Message-ID: <20180130021507.GA3261@simonLocalRHEL7.x64>
References: <1515665499-31710-1-git-send-email-wei.guo.simon@gmail.com>
 <1515665499-31710-14-git-send-email-wei.guo.simon@gmail.com>
 <20180123055219.GF3924@fergus.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180123055219.GF3924@fergus.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,
On Tue, Jan 23, 2018 at 04:52:19PM +1100, Paul Mackerras wrote:
> On Thu, Jan 11, 2018 at 06:11:26PM +0800, wei.guo.simon@gmail.com wrote:
> > From: Simon Guo <wei.guo.simon@gmail.com>
> > 
> > This patch adds 2 new APIs: kvmppc_copyto_vcpu_tm() and
> > kvmppc_copyfrom_vcpu_tm().  These 2 APIs will be used to copy from/to TM
> > data between VCPU_TM/VCPU area.
> > 
> > PR KVM will use these APIs for treclaim. or trchkpt. emulation.
> > 
> > Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>
> > Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
> 
> Actually, I take that back.  You have missed XER. :)
Thanks for the catch. I will fix that.

> 
> Paul.

BR,
- Simon
