Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F9DEB7C09
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Mar 2010 10:07:14 +1100 (EST)
Subject: Re: question about drivers/macintosh/windfarm_pm91.c
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Julia Lawall <julia@diku.dk>
In-Reply-To: <Pine.LNX.4.64.1003282355390.29824@ask.diku.dk>
References: <Pine.LNX.4.64.1003281746570.29824@ask.diku.dk>
	<1269810539.8599.330.camel@pasglop>
	<Pine.LNX.4.64.1003282355390.29824@ask.diku.dk>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 29 Mar 2010 10:07:07 +1100
Message-ID: <1269817627.8599.331.camel@pasglop>
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

On Sun, 2010-03-28 at 23:56 +0200, Julia Lawall wrote:
> I'll send something tomorrow.  I will perhaps keep the ifs, to
> maintain the style of the rest of the function.

Nah, remove them please or some janitor will send -another- patch :-)

Cheers,
Ben.
