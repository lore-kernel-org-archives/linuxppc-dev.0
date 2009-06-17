Return-Path: <glikely@secretlab.ca>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 2F2F0B71B8
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 16:22:10 +1000 (EST)
Received: from mail-yx0-f199.google.com (mail-yx0-f199.google.com
	[209.85.210.199]) by ozlabs.org (Postfix) with ESMTP id 667BFDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 16:22:08 +1000 (EST)
Received: by yxe37 with SMTP id 37so88381yxe.17
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 23:22:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <fa686aa40906162314p3e308bc4j2420a5f5570d5ae@mail.gmail.com>
References: <fa686aa40906080737h64bad3cfv32155e5b819d650b@mail.gmail.com>
	<1244751543-21977-1-git-send-email-wd@denx.de>
	<fa686aa40906162314p3e308bc4j2420a5f5570d5ae@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 17 Jun 2009 00:21:47 -0600
Message-ID: <fa686aa40906162321p43d7542bm6d3180991da63142@mail.gmail.com>
Subject: Re: [PATCH] mpc5xxx_get_bus_frequency(): use common code on MPC512x
	and MPC52xx
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 17, 2009 at 12:14 AM, Grant Likely<grant.likely@secretlab.ca> w=
rote:
> On Thu, Jun 11, 2009 at 2:19 PM, Wolfgang Denk<wd@denx.de> wrote:
>> So far, MPC512x used mpc512x_find_ips_freq() to get the bus frequency,
>> while MPC52xx used mpc52xx_find_ipb_freq(). =A0Despite the different
>> clock names (IPS vs. IPB) the code was identical.
>>
>> Use common code for both processor families.
>>
>> Signed-off-by: Wolfgang Denk <wd@denx.de>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Kumar Gala <galak@kernel.crashing.org>
>
> You probably already know this, but this patch doesn't apply against
> mainline, so I won't merge for 2.6.31.

Never mind; I'm smoking something.  The patch applies fine.

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
