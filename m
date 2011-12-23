Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 193C6B7218
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Dec 2011 00:35:11 +1100 (EST)
Subject: Re: [PATCH] arch/powerpc/kvm/e500: Additional module.h => export.h
 fixup
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Alexander Graf <agraf@suse.de>
In-Reply-To: <1324570863-11447-1-git-send-email-Kyle.D.Moffett@boeing.com>
Date: Fri, 23 Dec 2011 14:35:06 +0100
Message-Id: <26A61517-48D0-45D4-B3A3-D6C51FC1F91A@suse.de>
References: <1324570863-11447-1-git-send-email-Kyle.D.Moffett@boeing.com>
To: Kyle Moffett <Kyle.D.Moffett@boeing.com>
Cc: KVM list <kvm@vger.kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>,
 "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
 kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Avi Kivity <avi@redhat.com>, Scott Wood <scottwood@freescale.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 22.12.2011, at 17:21, Kyle Moffett wrote:

> This file, like many others, needs to include <linux/export.h>.
> 
> Signed-off-by: Kyle Moffett <Kyle.D.Moffett@boeing.com>

Thanks, I already applied a patch from Scott that addresses the same issue.


Alex
