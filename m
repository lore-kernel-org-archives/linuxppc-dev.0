Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 47D8EDF4BE
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:12:11 +1000 (EST)
Message-ID: <4863B1C1.1060300@freescale.com>
Date: Thu, 26 Jun 2008 10:12:01 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: add of_find_next_property and
	of_get_aliased_index
References: <1214424332-18496-1-git-send-email-timur@freescale.com>
	<762468c24d365ca8397b5833aa172b95@kernel.crashing.org>
	<4862AA19.3030502@freescale.com>
	<c293d4d144094e5b0311b703e64893dc@kernel.crashing.org>
In-Reply-To: <c293d4d144094e5b0311b703e64893dc@kernel.crashing.org>
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

> Well, yes, your suggested code doesn't allow punctuation either; but
> that wasn't my point, it doesn't allow numbers in names.  Why don't
> you just parse a number from the end?

Oh, you mean start at the end and go backwards?  Hmmm, I guess I could do that.

> The only thing a platform should ever use aliases for is if it needs
> to (for whatever purpose) find a specific device, that it cannot
> identify otherwise (via "reg", ...).  And then that platform code
> should look up the device by the alias, not look up the alias by the
> device -- there is no 1-1 mapping from device to alias!

Hmmm, I hadn't through about that.  I guess this patch isn't such a great idea
after all.  I rescind it.

-- 
Timur Tabi
Linux kernel developer at Freescale
