Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79BFC1A06BB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:53:46 +1100 (AEDT)
Subject: Re: [PATCH 3/3] ASoC: fsl_ssi: remove register defaults
To: Mark Brown <broonie@kernel.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 Fabio Estevam <festevam@gmail.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
References: <5677107C.60904@maciej.szmigiero.name>
 <CAOMZO5C+32Nn6+Nv9KeVrd_Qeso-wEZZNU45G8h+e6LHdMoQYw@mail.gmail.com>
 <CAOMZO5BE7=EdmEyMOq5WH=qv_0H3AGcyyDMJFoemLRJ=O5YLNw@mail.gmail.com>
 <20160111140038.GC6588@sirena.org.uk>
 <5693B7CC.8000905@maciej.szmigiero.name>
 <20160111145430.GE6588@sirena.org.uk> <5693CE21.8010009@tabi.org>
 <20160111161225.GJ6588@sirena.org.uk> <569455AA.4060907@tabi.org>
 <20160112013421.GW6588@sirena.org.uk>
From: Timur Tabi <timur@tabi.org>
Message-ID: <56945CA7.70100@tabi.org>
Date: Mon, 11 Jan 2016 19:53:43 -0600
MIME-Version: 1.0
In-Reply-To: <20160112013421.GW6588@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark Brown wrote:
> Quite possibly (it'll be more efficient and it's intended for such use
> cases) but as I said in my other reply that then has the issue that it
> implicitly gives default values to all the registers so I'd expect we
> still need to handle the cache initialisation explicitly (or
> alternatively the hardware sync with the cache on startup).

Why does REGCACHE_FLAT assume that all registers have a default value of 
0?  Shouldn't it have the same behavior w.r.t. cache values as 
REGCACHE_RBTREE?
