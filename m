Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 7DDB8B71C9
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Dec 2011 00:26:13 +1100 (EST)
Subject: Re: [PATCH 5/5] KVM: PPC: Book3s HV: Implement H_CLEAR_REF and
 H_CLEAR_MOD hcalls
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111215120417.GF20629@bloggs.ozlabs.ibm.com>
Date: Fri, 23 Dec 2011 14:26:08 +0100
Message-Id: <65D6C606-C95D-4309-BB30-A457CC5EBCCC@suse.de>
References: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
 <20111215120417.GF20629@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, KVM list <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 15.12.2011, at 13:04, Paul Mackerras wrote:

> This adds implementations for the H_CLEAR_REF (test and clear =
reference
> bit) and H_CLEAR_MOD (test and clear changed bit) hypercalls.  These
> hypercalls are not used by Linux guests at this stage, and these
> implementations are only compile tested.

Do we need them then? Are they mandatory in PAPR? I don't feel all that =
great having unused / untested code accessible from the guest.

Alex
