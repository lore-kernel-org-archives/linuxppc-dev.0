Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A3B422C0207
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Sep 2013 10:15:51 +1000 (EST)
Message-ID: <1378944911.4066.12.camel@pasglop>
Subject: Re: [PATCH] powerpc 8xx: Fixing issue with CONFIG_PIN_TLB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 12 Sep 2013 10:15:11 +1000
In-Reply-To: <1378939017.12204.409.camel@snotra.buserror.net>
References: <201309111644.r8BGiuDZ016325@localhost.localdomain>
 <1378939017.12204.409.camel@snotra.buserror.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Christophe Leroy <christophe.leroy@c-s.fr>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-11 at 17:36 -0500, Scott Wood wrote:
> I wonder why we don't start from entry 31 so we can actually make use of
> that autodecrement.  What will happen when we load the first normal TLB
> entry later on?  I don't see any setting of SPRN_MD_CTR after this code,
> so won't it overwrite entry 30 (the middle 8M) in the CONFIG_PIN_TLB
> case?
> 
> Ben, would patches like this be considered bugfixes as far as merging
> goes, or would they be for next given that it's something that's never
> really worked right and hasn't been touched in years?

Since they don't affect anything outside of 8xx, I'm happy to take them
until around -rc2 or 3. But it's your call really.

Cheers,
Ben.
