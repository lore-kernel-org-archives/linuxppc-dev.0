Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 651C7DDE44
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 14:31:42 +1100 (EST)
In-Reply-To: <989B956029373F45A0B8AF02970818900D41BD@zch01exm26.fsl.freescale.net>
References: <989B956029373F45A0B8AF02970818900D41BD@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EF78DCF9-DEC9-4D2F-AE0E-AD416BE91B81@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/3] 8349emds default dts updates for USB change
Date: Mon, 5 Feb 2007 21:31:12 -0600
To: "Li Yang-r58472" <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Paul <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 5, 2007, at 9:17 PM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Monday, February 05, 2007 11:07 PM
>> To: Li Yang-r58472
>> Cc: Paul; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH 3/3] 8349emds default dts updates for USB change
>>
>>
>> On Feb 5, 2007, at 3:10 AM, Li Yang wrote:
>>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> ---
>>> arch/powerpc/boot/dts/mpc8349emds.dts |    6 ++++++
>>> 1 files changed, 6 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/powerpc/boot/dts/mpc8349emds.dts b/arch/powerpc/
>>> boot/dts/mpc8349emds.dts
>>> index efceb34..ba31af1 100644
>>> --- a/arch/powerpc/boot/dts/mpc8349emds.dts
>>> +++ b/arch/powerpc/boot/dts/mpc8349emds.dts
>>> @@ -39,6 +39,11 @@
>>> 		reg = <00000000 10000000>;	// 256MB at 0
>>> 	};
>>> +	bcsr@f8000000 {
>>> +		device_type = "board-control";
>>> +		reg = <e2400000 8000>;
>>
>> Are the bcsr's at f8000000 or e2400000?
>
> According to the default u-boot configuration in tree, it is e2400000.

Fine, so what is it bcsr@f8000000?

- k
