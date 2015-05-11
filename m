Return-Path: <wsa@the-dreams.de>
Received: from pokefinder.org (sauhun.de [89.238.76.85])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7E1E61A02E8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 May 2015 17:34:47 +1000 (AEST)
Date: Mon, 11 May 2015 09:34:28 +0200
From: wsa@the-dreams.de
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] i2c: powermac: don't workaround for keywest
Message-ID: <20150511073428.GA3110@schokonusskuchen.bad>
References: <1431192213-2904-1-git-send-email-wsa@the-dreams.de>
 <20150510183431.GA1510@katana>
 <1431296087.13039.13.camel@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1431296087.13039.13.camel@kernel.crashing.org>
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

On Mon, May 11, 2015 at 08:14:47AM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2015-05-10 at 20:34 +0200, Wolfram Sang wrote:
> > Okay, so this patch is bogus. I understand now that onyx uses another
> > codec than TAS, so this change will regress on other machines.
> > However,
> > it shows that this unconditional instantiation of the TAS breaks sound
> > on Macintoshs which still need non-aoa sound support. I assume there
> > will be noone in the near future to convert Keywest to AOA, so we'll
> > need to find a hackish way around this instantiation problem.
>=20
> Converting the old macs that use TAS shouldn't be *that* hard, main
> problem is I don't have the hardware to test...

Dan and Mark (on CC) have been very helpful with testing. Maybe they are
also in to test "the proper solution"?
