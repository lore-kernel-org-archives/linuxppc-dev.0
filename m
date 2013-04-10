Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C09842C00C8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 01:16:37 +1000 (EST)
Subject: Re: [PATCH] powerpc: remove "config MPC10X_OPENPIC"
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1365449711.1830.130.camel@x61.thuisdomein>
Date: Wed, 10 Apr 2013 10:16:31 -0500
Message-Id: <D9A862AE-0B1F-45F0-AA27-2A13C49E6774@kernel.crashing.org>
References: <1365449711.1830.130.camel@x61.thuisdomein>
To: Paul Bolle <pebolle@tiscali.nl>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Apr 8, 2013, at 2:35 PM, Paul Bolle wrote:

> The last users of Kconfig symbol MPC10X_OPENPIC were removed in v2.6.27.
> Its Kconfig entry can be removed now.
> 
> Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
> ---
> Untested.
> 
> arch/powerpc/platforms/embedded6xx/Kconfig | 5 -----
> 1 file changed, 5 deletions(-)

applied to next

- k
