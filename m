Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EEE641A0004
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Jul 2014 22:33:57 +1000 (EST)
Message-ID: <53B54DB2.1000805@suse.de>
Date: Thu, 03 Jul 2014 14:33:54 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 5/6 v2] KVM: PPC: Book3E: Add ONE_REG AltiVec support
References: <1404142497-6430-1-git-send-email-mihai.caraman@freescale.com>
 <1404142497-6430-6-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404142497-6430-6-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 30.06.14 17:34, Mihai Caraman wrote:
> Add ONE_REG support for AltiVec on Book3E.
>
> Signed-off-by: Mihai Caraman <mihai.caraman@freescale.com>

Any chance we can handle these in generic code?


Alex
