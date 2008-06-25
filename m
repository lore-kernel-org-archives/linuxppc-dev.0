Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DCF37DDFA0
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Jun 2008 06:27:59 +1000 (EST)
Message-ID: <4862AA19.3030502@freescale.com>
Date: Wed, 25 Jun 2008 15:27:05 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add of_find_next_property and
	of_get_aliased_index
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
	<762468c24d365ca8397b5833aa172b95@kernel.crashing.org>
In-Reply-To: <762468c24d365ca8397b5833aa172b95@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

> It returns 2 for both "i2c-1" and "i2c-2".

Well, I'm assuming that the alias property names will follow the current
convention of xxxxnn where xxxx is a name and nn is a number.  No dashes or
other punctuation.

> Also, alias names do not have any significance in general, they are
> just handy shortcut names for humans to use; it would be better not
> to overload this.  What do you want to use this for?

As an alternative to cell-index or device-id for enumerating devices.  The
consensus from the '"cell-index" vs. "index" vs. no index in I2C device nodes'
thread is that aliases are to be used to enumerate devices.

-- 
Timur Tabi
Linux kernel developer at Freescale
