Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3036B1A0044
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Jul 2014 18:29:26 +1000 (EST)
Message-ID: <53B665E2.9020504@suse.de>
Date: Fri, 04 Jul 2014 10:29:22 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Mihai Caraman <mihai.caraman@freescale.com>, kvm-ppc@vger.kernel.org
Subject: Re: [RFC PATCH 0/4] KVM Book3E support for HTW guests
References: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
In-Reply-To: <1404398727-12844-1-git-send-email-mihai.caraman@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 03.07.14 16:45, Mihai Caraman wrote:
> KVM Book3E support for Hardware Page Tablewalk enabled guests.

It looks reasonably straight forward to me, though I have to admit that 
I find the sind conditions pretty confusing.

Scott, would you mind to have a look at this set too? :)


Thanks a lot!

Alex
