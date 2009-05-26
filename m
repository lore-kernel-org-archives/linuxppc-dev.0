Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3755EDE3B2
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 04:03:42 +1000 (EST)
Message-ID: <4A1C2E66.7020902@freescale.com>
Date: Tue, 26 May 2009 13:01:10 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 1/2 v8] powerpc: introduce macro spin_event_timeout()
References: <1242761199-17875-1-git-send-email-timur@freescale.com>	
	<1242761199-17875-2-git-send-email-timur@freescale.com>	
	<9e4733910905251046y5f7377f4y49ce72e775faef16@mail.gmail.com>	
	<ed82fe3e0905252027y198e78ct821753acacb1bdb1@mail.gmail.com>	
	<4A1C16DF.9090802@freescale.com> <4A1C20EA.5080603@freescale.com>
	<9e4733910905261056v7a1a8e77ie6f273820ce1fd3e@mail.gmail.com>
In-Reply-To: <9e4733910905261056v7a1a8e77ie6f273820ce1fd3e@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Geoff Thorpe <Geoff.Thorpe@freescale.com>,
	smaclennan@pikatech.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> Then if I don't care about the result (which I think is the common case)...
> 
> rc = spin_event_timeout(in_be32(x) & 0x14, ...);
> if (rc)
>    timeout_happened;

That's another way of doing it, but I'm already at version 9 of my patch, and I'm not inclined to make any changes that don't add any real functionality.  Every time I post a new version of this patch, someone new comes out of the woodwork to tell me that I should do it a different way.  Where were you two months ago?

-- 
Timur Tabi
Linux kernel developer at Freescale
