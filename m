Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EC451B70D5
	for <linuxppc-dev@ozlabs.org>; Sun, 26 Sep 2010 20:12:48 +1000 (EST)
Message-ID: <4C9F1D09.3040907@windriver.com>
Date: Sun, 26 Sep 2010 18:14:33 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: David Hagood <david.hagood@gmail.com>
Subject: Re: MPC8641D PEX: programming OWBAR in Endpoint mode?
References: <08f8439b89ad5771221aaba1cee86fc4.squirrel@localhost>	
	<52CF90264091A14888078A031D780F4306C8C0FF@ism-mail03.corp.ad.wrs.com>	
	<1285240268.2454.8.camel@chumley>	
	<52CF90264091A14888078A031D780F4306C8C14B@ism-mail03.corp.ad.wrs.com>	
	<409c3f6d508ece73c18f6ce750513b22.squirrel@localhost>	
	<52CF90264091A14888078A031D780F4306C8C176@ism-mail03.corp.ad.wrs.com>	
	<1285325425.2454.11.camel@chumley> <4C9DC510.8010403@windriver.com>
	<1285415473.2454.15.camel@chumley>
In-Reply-To: <1285415473.2454.15.camel@chumley>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Hagood wrote:
> On Sat, 2010-09-25 at 17:46 +0800, tiejun.chen wrote:
>> As a summary you have no any issue to access InBound/BAR/LAW.
> 
> Correct: full access to the inbound.
>> And I remember there is only one
>> requirement to OutBound, and that is the window address should be aligned based
>> on the size from OWS. Are you sure?
> Yes. As my first test I've been using 4k and 64k sizes, aligned on 16M
> boundaries.
>> And did you try to configure OutBound REGS when RC mode? If so I'm afraid we may
>> miss some errata on EP.
> In RC mode the built-in drivers take over.

Can you confirm the build-in driver can write/read OutBound correctly on your
target?

-Tiejun

> 
> 
> 
