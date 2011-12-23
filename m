Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id F416FB7238
 for <linuxppc-dev@ozlabs.org>; Sat, 24 Dec 2011 00:36:23 +1100 (EST)
Subject: Re: [PATCH 0/5] Make use of hardware reference and change bits in HPT
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
Date: Fri, 23 Dec 2011 14:36:19 +0100
Message-Id: <BEBB9A49-5273-42AF-A1FC-E0566EBB8316@suse.de>
References: <20111215120018.GA20629@bloggs.ozlabs.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 15.12.2011, at 13:00, Paul Mackerras wrote:

> This series of patches builds on top of my previous series and
> modifies the Book3S HV memory management code to use the hardware
> reference and change bits in the guest hashed page table.  This makes
> kvm_age_hva() more efficient, lets us implement the dirty page
> tracking properly (which in turn means that things like VGA emulation
> in qemu can work), and also means that we can supply hardware
> reference and change information to the guest -- not that Linux guests
> currently use that information, but possibly they will want it in
> future, and there is an interface defined in PAPR for it.

I applied Patches 1-4 to kvm-ppc-next.


Alex
