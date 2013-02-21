Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx.suse.de", Issuer "SUSE CA suse.de" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 26FB72C0092
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Feb 2013 00:33:46 +1100 (EST)
Subject: Re: [PATCH 3/4] KVM: PPC: Book3S HV: Preserve guest CFAR register
 value
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20130205041051.GD20303@drongo>
Date: Thu, 21 Feb 2013 14:33:37 +0100
Message-Id: <E729B670-DF40-491B-8004-98E6974E919F@suse.de>
References: <20130205040902.GA20303@drongo> <20130205041051.GD20303@drongo>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 05.02.2013, at 05:10, Paul Mackerras wrote:

> The CFAR (Come-From Address Register) is a useful debugging aid that
> exists on POWER7 processors.  Currently HV KVM doesn't save or restore
> the CFAR register for guest vcpus, making the CFAR of limited use in
> guests.
> 
> This adds the necessary code to capture the CFAR value saved in the
> early exception entry code (it has to be saved before any branch is
> executed), save it in the vcpu.arch struct, and restore it on entry
> to the guest.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Acked-by: Alexander Graf <agraf@suse.de>


Alex
