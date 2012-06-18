Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0E0CCB70B4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jun 2012 22:57:17 +1000 (EST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] i2c/powermac: Improve detection of devices from
 device-tree
References: <1340014606.2372.13.camel@pasglop>
Date: Mon, 18 Jun 2012 14:57:08 +0200
In-Reply-To: <1340014606.2372.13.camel@pasglop> (Benjamin Herrenschmidt's
 message of "Mon, 18 Jun 2012 20:16:46 +1000")
Message-ID: <m28vfkvkuz.fsf@igel.home>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> This patch adds a number of workarounds for broken Apple device-trees
> mostly around sound chips. It handles creating the missing audio codec
> devices and works around various issues with missing addresses or
> missing compatible properties.
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> Andreas, this is what I've been cooking up today. Still mostly untested
> though, so handle with care :-) But it gives you the basic premises.

Sucessfully tested on PowerBook6,7 and PowerMac7,3 (both tas3004, the
latter with the deq workaround).

These are the remaining failures on PowerMac7,3:

i2c i2c-5: No i2c address for /ht@0,f2000000/pci@1/mac-io@7/i2c@18000/i2c-modem
i2c i2c-6: i2c-powermac: modalias failure on /u3@0,f8000000/i2c@f8001000/cereal@1c0

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
