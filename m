Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5C0BADDFAF
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Apr 2009 00:51:12 +1000 (EST)
Date: Mon, 13 Apr 2009 16:51:00 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] therm_pm72: Convert to a new-style i2c driver
Message-ID: <20090413165100.36b85c68@hyperion.delvare>
In-Reply-To: <20090413160927.3b8675b8@hyperion.delvare>
References: <20090413160927.3b8675b8@hyperion.delvare>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Apr 2009 16:09:27 +0200, Jean Delvare wrote:
> The legacy i2c binding model is going away soon, so convert the
> macintosh therm_pm72 driver to the new model or it will break.
> 
> This is really a quick and dirty conversion, that should do the trick
> for now, but no doubt that something cleaner can be done if anyone is
> interested.
> 
> Signed-off-by: Jean Delvare <khali@linux-fr.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> Can anyone please run-test this patch? I could only build-test it.

Damn, I forgot once again. You need to apply the following patch
beforehand:
ftp://ftp.kernel.org/pub/linux/kernel/people/jdelvare/linux-2.6/jdelvare-i2c/i2c-loosen-driver-check.patch

I'll push this patch to Linus now.

-- 
Jean Delvare
