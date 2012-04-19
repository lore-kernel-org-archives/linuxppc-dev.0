Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:32:0:1:25:1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1BF7BB6FEC
 for <linuxppc-dev@ozlabs.org>; Thu, 19 Apr 2012 19:34:44 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 01/15] i2c/powermac: Register i2c devices from device-tree
References: <1334823416-9138-1-git-send-email-benh@kernel.crashing.org>
 <1334823416-9138-2-git-send-email-benh__33169.052625499$1334826821$gmane$org@kernel.crashing.org>
Date: Thu, 19 Apr 2012 11:34:33 +0200
In-Reply-To: <1334823416-9138-2-git-send-email-benh__33169.052625499$1334826821$gmane$org@kernel.crashing.org>
 (Benjamin Herrenschmidt's message of "Thu, 19 Apr 2012 18:16:42
 +1000")
Message-ID: <m2bomo2hg6.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: khali@linux-fr.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> +		/* Make up a modalias. Note: we to _NOT_ want the standard
> +		 * i2c drivers to match with any of our powermac stuff
> +		 * unless they have been specifically modified to handle
> +		 * it on a case by case basis. For example, for thermal
> +		 * control, things like lm75 etc... shall match with their
> +		 * corresponding windfarm drivers, _NOT_ the generic ones,
> +		 * so we force a prefix of AAPL, onto the modalias to

s/AAPL,/MAC,/

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
