Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-05.arcor-online.net (mail-in-05.arcor-online.net
	[151.189.21.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 234C1DDF1F
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 08:53:52 +1000 (EST)
In-Reply-To: <DD2F76DD-4427-4182-B17A-B470CF14E41D@kernel.crashing.org>
References: <460292FA.8050206@mindspring.com>	<E9D1DC31-9730-4431-9414-0870FDD3EAF6@kernel.crashing.org>	<4602BD39.9020102@mindspring.com>
	<20070322125712.2229ff99.kim.phillips@freescale.com>
	<4602C74F.6040402@mindspring.com>
	<DD2F76DD-4427-4182-B17A-B470CF14E41D@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2cf7d4ce28b4db08cd9ede0eeded130a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: MPC83xx SDMR setup error
Date: Tue, 27 Mar 2007 00:53:42 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Can you send this with a more proper header/subject and Signed-off-
> by, according to Documentation/SubmittingPatches

>> -	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 >>
>> +	out_be32(&sdma->sdmr, (QE_SDMR_GLB_1_MSK | (0x1 <<
>>  					QE_SDMR_CEN_SHIFT)));

When you resend, please change the line break to
something more reasonable too (like, at the | sign) --
it might have avoided this bug in the first place.


Segher
