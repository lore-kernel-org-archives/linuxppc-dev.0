Return-Path: <wg@grandegger.com>
Message-ID: <48479A79.9010801@grandegger.com>
Date: Thu, 05 Jun 2008 09:49:13 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] [POWERPC] 85xx: add board support for the TQM8548
	modules
References: <1212130188-28835-1-git-send-email-wg@grandegger.com>
	<1212130188-28835-2-git-send-email-wg@grandegger.com>
	<20080602020352.GB19393@yookeroo.seuss>
	<479BA7CE-CD12-4935-87EB-E69025D408E6@kernel.crashing.org>
	<4845181E.8040603@grandegger.com>
	<07AEED44-7DEB-46C1-B028-3EFA274CEB11@kernel.crashing.org>
	<20080603223905.GA22982@yookeroo.seuss>
	<484663DB.5000905@grandegger.com>
	<02EC7209-F395-4C01-A445-E111E6E54A25@kernel.crashing.org>
	<48478B1C.9040300@grandegger.com>
	<EC50D666-4E20-462B-880F-502E61A76EFA@kernel.crashing.org>
In-Reply-To: <EC50D666-4E20-462B-880F-502E61A76EFA@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>>>>>
>>>> I'm puzzled. Could someone point me to some real code where cell-index
>>>> is used as a pointer into some global data. Sorry for my ignorance.
>>>
>>> http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057254.html
>>
>> Yep, I saw that it's used for I2C (and SPI). But "cell-index" is also
>> defined for network, serial and PCI nodes, which are also assigned via
>> aliases.
> 
> Some of this is for the future.  There are other SoC registers (like on
> 85xx in GUTS) that need index information.

Ah, OK, Thanks.

Wolfgang.
