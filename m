Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1045C2C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Dec 2012 02:07:04 +1100 (EST)
Subject: Re: [PATCH 00/12] KVM: PPC: 64-bit Book3E arch support
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
Date: Sat, 1 Dec 2012 16:06:55 +0100
Message-Id: <42B84697-F08F-48F6-B50A-EEF2D7E045FD@suse.de>
References: <1349972009-23027-1-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 11.10.2012, at 18:13, Mihai Caraman wrote:

> This patchset adds arch support to KVM for 64-bit Book3E PowerPC =
procesosrs
> with Embedded.Hypervisor category. The support is limited to the =
bolted TLB miss
> exception handlers version and was validated on Freescale's e5500 =
cores
> using P5020DS boards.

Thanks, applied all except for 11/12 with their respective small =
fine-tunings to kvm-ppc-next :).


Alex
