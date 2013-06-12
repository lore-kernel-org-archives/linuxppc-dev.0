Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by ozlabs.org (Postfix) with ESMTP id 790822C0095
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 23:19:03 +1000 (EST)
Subject: Re: [v3][KVM][PATCH 1/1] kvm:ppc: control doorbell exception with
 CONFIG_PPC_DOORBELL
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1368410445-4969-1-git-send-email-tiejun.chen@windriver.com>
Date: Wed, 12 Jun 2013 15:18:59 +0200
Message-Id: <AC1A942D-1110-4800-89A1-90E8A959C246@suse.de>
References: <1368410445-4969-1-git-send-email-tiejun.chen@windriver.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 13.05.2013, at 04:00, Tiejun Chen wrote:

> We can only use CONFIG_PPC_DOORBELL to control whether
> the doorbell exception should be enabled.
> 
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>

Thanks, applied to kvm-ppc-queue with a slightly changed patch description:

    KVM: PPC: Guard doorbell exception with CONFIG_PPC_DOORBELL

    Availablity of the doorbell_exception function is guarded by
    CONFIG_PPC_DOORBELL. Use the same define to guard our caller
    of it.

    Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>
    [agraf: improve patch description]
    Signed-off-by: Alexander Graf <agraf@suse.de>
