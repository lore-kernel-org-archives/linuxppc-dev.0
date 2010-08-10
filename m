Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C1907B70CC
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Aug 2010 14:19:25 +1000 (EST)
Subject: Re: Questions about powerpc kernel tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Terren Chow <terren.chow@gmail.com>
In-Reply-To: <AANLkTinqKv1OXDBtQfg0jOyw=04FQcAvoE8CPmMN7M5_@mail.gmail.com>
References: <AANLkTinqKv1OXDBtQfg0jOyw=04FQcAvoE8CPmMN7M5_@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 10 Aug 2010 14:19:18 +1000
Message-ID: <1281413958.28245.17.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-08-10 at 10:39 +0800, Terren Chow wrote:
> Hi Ben:
>     I'm not quite clearly know about the powerpc kernel tree histroy.
> why the tags in the powerpc kernel tree are only update to 2.6.26-rc9
> at about 2 years ago?  

Not sure what you're looking at but your shouldn't need to use the
"powerpc kernel tree" whatever tree this is :-) All our work goes into
Linus tree on a regular basis, so unless you are specifically looking at
the powerpc "next" git branch aimed at the next merge window, there
should be nothing of interest to you there.

Ben.
