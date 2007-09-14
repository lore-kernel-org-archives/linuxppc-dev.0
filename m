Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5FCDADDDFE
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 23:47:19 +1000 (EST)
In-Reply-To: <F0AE60D7-68AE-43F9-AD6F-5D7790387217@kernel.crashing.org>
References: <11897176803590-git-send-email-galak@kernel.crashing.org>
	<1189717681533-git-send-email-galak@kernel.crashing.org>
	<1189717683471-git-send-email-galak@kernel.crashing.org>
	<11897176841013-git-send-email-galak@kernel.crashing.org>
	<11897176851400-git-send-email-galak@kernel.crashing.org>
	<1189717687832-git-send-email-galak@kernel.crashing.org>
	<11897176884163-git-send-email-galak@kernel.crashing.org>
	<1189717690413-git-send-email-galak@kernel.crashing.org>
	<1189717691261-git-send-email-galak@kernel.crashing.org>
	<11897176931664-git-send-email-galak@kernel.crashing.org>
	<118971769498-git-send-email-galak@kernel.crashing.org>
	<11897176964013-git-send-email-galak@kernel.crashing.org>
	<11897176992010-git-send-email-galak@kernel.crashing.org>
	<11897177013875-git-send-email-galak@kernel.crashing.org>
	<11897177032288-git-send-email-galak@kernel.crashing.org>
	<11897177042582-git-send-email-galak@kernel.crashing.org>
	<11897177052448-git-send-email-galak@kernel.crashing.org!
	! > <11897177071168-git-send-email-galak@kernel.crashing.org>
	<11897177091972-git-send-email-galak@kernel.crashing.org>
	<11897177102281-git-send-email-galak@kernel.crashing.org>
	<1189717711656-git-send-email-galak@kernel.crashing.org>
	<11897177132273-git-send-email-galak@kernel.crashing.org>
	<11897177143496-git-send-email-galak@kernel.crashing.org>
	<18154.32614.502824.264341@cargo.ozlabs.ibm.com>
	<F0AE60D7-68AE-43F9-AD6F-5D7790387217@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <298DD214-407D-4BA3-A4D0-7B4528C00D4C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 22/22] [POWERPC] MPC832x_RDB: Update dts to use SPI1 in QE,
	register mmc_spi stub
Date: Fri, 14 Sep 2007 08:50:16 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 14, 2007, at 8:21 AM, Kumar Gala wrote:

>
> On Sep 14, 2007, at 7:32 AM, Paul Mackerras wrote:
>
>> Kumar Gala writes:
>>
>>> From: Anton Vorontsov <avorontsov@ru.mvista.com>
>>>
>>> mmc_spi already tested to work. When it will hit mainline
>>> the only change that will be needed is replacing "spidev"
>>> with "mmc_spi".
>>
>> That's a *remarkably* uninformative commit message.  And what's the
>> use of putting in something about "when it will hit mainline" when
>> this is the point where it hits mainline?
>
> Yeah, I was afraid of that when I glanced at Anton's patches.
>
> I think the comment is in reference to a mainline SPI subsystem
> change intended for 2.6.24.

Let me know how you want to handle this.  I see two options.

1. merge patch as is (with new commit message, see below)
2. drop patch for now and wait for mmc_spi to be merged.

Take a look at the following for Anton's comments on the situation:

http://ozlabs.org/pipermail/linuxppc-dev/2007-August/041370.html

How about a commit message like the following:

     [POWERPC] MPC832x_RDB: Update dts to use SPI1 in QE, register  
mmc_spi stub

     Enabled using SPI controller on the MPC832x RDB board.  We  
currently use
     a modalias of "spidev" as a place holder (replace with  
"mmc_spie") until
     the mmc_spi driver support is merged in.

     This gets us the ability to test SPI until then.

     Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
     Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

- k
