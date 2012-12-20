Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E22D2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2012 02:09:05 +1100 (EST)
Subject: Re: [PATCH] KVM: PPC: Fix mfspr/mtspr MMUCFG emulation
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1356015159-7777-1-git-send-email-mihai.caraman@freescale.com>
Date: Thu, 20 Dec 2012 16:08:57 +0100
Message-Id: <07780918-6443-4D1F-BC60-597533FD2C21@suse.de>
References: <1356015159-7777-1-git-send-email-mihai.caraman@freescale.com>
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


On 20.12.2012, at 15:52, Mihai Caraman wrote:

> On mfspr/mtspr emulation path Book3E's MMUCFG SPR with value 1015 clashes
> with G4's MSSSR0 SPR. Move MSSSR0 emulation from generic part to Books3S.
> MSSSR0 also clashes with Book3S's DABRX SPR. DABRX was not explicitly
> handled so Book3S execution flow will behave as before.
> 
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Thanks, applied to ppc-queue.


Alex
