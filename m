Return-Path: <david.hagood@gmail.com>
Received: from mail-yw0-f42.google.com (mail-yw0-f42.google.com
	[209.85.213.42]) by ozlabs.org (Postfix) with ESMTP id 23CE9B70D0
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2010 21:51:18 +1000 (EST)
Received: by ywa6 with SMTP id 6so2093276ywa.15
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2010 04:51:17 -0700 (PDT)
Subject: Re: MPC8641D PEX: programming OWBAR in Endpoint mode?
From: David Hagood <david.hagood@gmail.com>
To: "tiejun.chen" <tiejun.chen@windriver.com>
In-Reply-To: <4C9DC510.8010403@windriver.com>
References: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>
	<52CF90264091A14888078A031D780F4306C8C0FF@ism-mail03.corp.ad.wrs.com>
	<1285240268.2454.8.camel@chumley>
	<52CF90264091A14888078A031D780F4306C8C14B@ism-mail03.corp.ad.wrs.com>
	<409c3f6d508ece73c18f6ce750513b22.squirrel@localhost>
	<52CF90264091A14888078A031D780F4306C8C176@ism-mail03.corp.ad.wrs.com>
	<1285325425.2454.11.camel@chumley>  <4C9DC510.8010403@windriver.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 25 Sep 2010 06:51:13 -0500
Message-ID: <1285415473.2454.15.camel@chumley>
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

On Sat, 2010-09-25 at 17:46 +0800, tiejun.chen wrote:
> As a summary you have no any issue to access InBound/BAR/LAW.

Correct: full access to the inbound.
> And I remember there is only one
> requirement to OutBound, and that is the window address should be aligned based
> on the size from OWS. Are you sure?
Yes. As my first test I've been using 4k and 64k sizes, aligned on 16M
boundaries.
> 
> And did you try to configure OutBound REGS when RC mode? If so I'm afraid we may
> miss some errata on EP.
In RC mode the built-in drivers take over.
