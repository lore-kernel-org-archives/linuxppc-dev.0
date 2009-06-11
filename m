Return-Path: <hs@denx.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9EA78B711A
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 16:27:26 +1000 (EST)
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 35F9CDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 16:27:24 +1000 (EST)
Message-ID: <4A309E43.4040007@denx.de>
Date: Thu, 11 Jun 2009 08:03:47 +0200
From: Heiko Schocher <hs@denx.de>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] 83xx: add support for the kmeter1 board.
References: <49F00605.1080605@denx.de>
	<6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
	<20090427180503.GB10292@ld0162-tx32.am.freescale.net>
	<49F68943.3090800@denx.de>
	<20090428163540.GA2193@ld0162-tx32.am.freescale.net>
	<49F7DC0C.3080409@denx.de>
	<C934E2FC-7597-4D10-AA2F-F28884D1DD1B@kernel.crashing.org>
In-Reply-To: <C934E2FC-7597-4D10-AA2F-F28884D1DD1B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Kumar,

Kumar Gala wrote:
> On Apr 28, 2009, at 11:48 PM, Heiko Schocher wrote:
> 
>> The following series implements basic board support for
>> the kmeter1 board from keymile, based on a MPC8360.
[...]
>> +        };
>> +    };
>> +};
> 
> Sorry for taking so long to review this again.

No problem, we are all just working

Reworked patch with your comments will follow, thanks.

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
