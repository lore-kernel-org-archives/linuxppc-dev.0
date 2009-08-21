Return-Path: <Tiejun.Chen@windriver.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail7.windriver.com",
	Issuer "Intel External Basic Issuing CA 3A" (not verified))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A52C5B7C10
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 21 Aug 2009 16:39:13 +1000 (EST)
Message-ID: <4A8E4126.3000405@windriver.com>
Date: Fri, 21 Aug 2009 14:39:34 +0800
From: "tiejun.chen" <tiejun.chen@windriver.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 2/2] powerpc/405ex: support cuImage via included dtb
References: <1250562484-16415-1-git-send-email-tiejun.chen@windriver.com>
	<20090820133118.GF2530@zod.rchland.ibm.com>
	<4A8E3396.9030006@windriver.com> <200908210835.58288.sr@denx.de>
In-Reply-To: <200908210835.58288.sr@denx.de>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Stefan Roese wrote:
> On Friday 21 August 2009 07:41:42 tiejun.chen wrote:
>>>> +static void kilauea_fixups(void)
>>>> +{
>>>> +	/*TODO: Please change this as the real. Note that should be
>>>> 33MHZ~100MHZ.*/
>>> What does that mean?
>> It's difficult to check the sysclk value on all revision Kilauea board for
>> me, and we have to check this value only by the real target, not by reading
>> one register. So I hope it's safe to remind other guys here.
> 
> Kilauea uses this value (33.333MHz) on all board revisions, AFAIK. Your 
> comment is a bit confusing. I suggest that you just remove it.
> 

I appreciate your help.

Best Regards
Tiejun

> Cheers,
> Stefan
> 
