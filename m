Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E62B3DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 02:15:59 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C74D158@zch01exm26.fsl.freescale.net>
References: <11854393721520-git-send-email-wei.zhang@freescale.com>
	<11854393733580-git-send-email-wei.zhang@freescale.com>
	<98CA70A1-9888-4508-A0E9-0EB28C14945F@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C74D158@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <363cce0e331102968838e3cb9db5f166@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5 v3] Add the explanation and a sample of RapidIO OF
	node to the document of booting-without-of.txt file.
Date: Tue, 31 Jul 2007 18:15:48 +0200
To: "Zhang Wei-r63237" <Wei.Zhang@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +    - #address-cells : Address representation for
>> "rapidio" devices.
>>> +      This field represents the number of cells needed to represent
>>> +      the RapidIO address of the registers.
>>
>> Can you explain this a little further.  I'm a bit confused by
>> 'RapidIO address of the registers'.
>>
> I want to present "This field represents the number of cells [needed to
> represent the RapidIO address] of the registers."
> Maybe I should remove 'of the registers' to be more clear.

This is completely content-free anyway; the semantics of
#address-cells (and #size-cells, which you forgot) are
already defined in the base OF spec; what you _should_ be
defining here is a) the required value of #address-cells
for a rapidio bus; and b) how addresses on that bus are
represented (simply as a 64-bit integer, encoded as a
pair of 32-bit integers as usual; but it needs to be said).


Segher
