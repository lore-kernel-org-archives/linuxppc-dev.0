Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CD0D5B6F06
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2011 16:47:33 +1000 (EST)
Message-ID: <56030.94.211.195.167.1301986049.squirrel@gate.crashing.org>
In-Reply-To: <1301984051-18413-16-git-send-email-benh@kernel.crashing.org>
References: <1301984051-18413-1-git-send-email-benh@kernel.crashing.org>
	<1301984051-18413-16-git-send-email-benh@kernel.crashing.org>
Date: Tue, 5 Apr 2011 08:47:29 +0200 (CEST)
Subject: Re: [PATCH 15/15] powerpc: Improve prom_printf()
From: "Segher Boessenkool" <segher@kernel.crashing.org>
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

> +		case 'd':
> +			++q;
> +			vs = va_arg(args, long);

'd' takes an int, not a long.

> +			if (vs < 0) {
> +				prom_print("-");

RELOC()?


Segher
