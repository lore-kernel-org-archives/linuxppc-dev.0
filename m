Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 042251A001B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 08:19:57 +1000 (AEST)
Message-ID: <1431296087.13039.13.camel@kernel.crashing.org>
Subject: Re: [PATCH] i2c: powermac: don't workaround for keywest
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 11 May 2015 08:14:47 +1000
In-Reply-To: <20150510183431.GA1510@katana>
References: <1431192213-2904-1-git-send-email-wsa@the-dreams.de>
 <20150510183431.GA1510@katana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Mark Elliott <txlitebeer@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-i2c@vger.kernel.org, Dan DeVoto <dand1972@yahoo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-05-10 at 20:34 +0200, Wolfram Sang wrote:
> Okay, so this patch is bogus. I understand now that onyx uses another
> codec than TAS, so this change will regress on other machines.
> However,
> it shows that this unconditional instantiation of the TAS breaks sound
> on Macintoshs which still need non-aoa sound support. I assume there
> will be noone in the near future to convert Keywest to AOA, so we'll
> need to find a hackish way around this instantiation problem.

Converting the old macs that use TAS shouldn't be *that* hard, main
problem is I don't have the hardware to test...

Ben.
