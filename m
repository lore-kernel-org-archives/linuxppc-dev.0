Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNhXT5QxNzDvpP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 10:30:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: Re: [PATCH] powernv: Clear SPRN_PSSCR when a POWER9 CPU comes online
In-Reply-To: <1479838000-380-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1479838000-380-1-git-send-email-ego@linux.vnet.ibm.com>
Date: Wed, 23 Nov 2016 10:30:15 +1100
Message-ID: <87bmx7um7s.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> Ensure that PSSCR is set to a safe value corresponding to no
> state-loss each time a POWER9 CPU comes online.

Is this a bug fix? I can't tell from the change log.

cheers
