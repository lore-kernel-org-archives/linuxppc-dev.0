Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE90B2C00E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Jul 2012 23:33:47 +1000 (EST)
Subject: Re: [Qemu-ppc] [RFC PATCH 03/17] KVM: PPC64: booke: Add EPCR support
 in sregs
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
Date: Wed, 4 Jul 2012 15:33:40 +0200
Message-Id: <4E5FF9AC-1759-423F-A918-3BA0AEAE5349@suse.de>
References: <1340627195-11544-1-git-send-email-mihai.caraman@freescale.com>
 <1340627195-11544-4-git-send-email-mihai.caraman@freescale.com>
To: Mihai Caraman <mihai.caraman@freescale.com>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 25.06.2012, at 14:26, Mihai Caraman wrote:

> Add KVM_SREGS_E_64 feature and EPCR spr support in get/set sregs
> for 64-bit hosts.

Please also implement a ONE_REG interface while at it. Over time, I'd =
like to move towards ONE_REG instead of the messy regs/sregs API.


Alex
