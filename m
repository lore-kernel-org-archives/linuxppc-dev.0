Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id D6B7CB7CC1
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 18:34:46 +1100 (EST)
Message-ID: <4B5E9ACF.7000206@grandegger.com>
Date: Tue, 26 Jan 2010 08:33:35 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Subject: Re: [PATCH/RFC 2/2] 5200: improve i2c bus error recovery
References: <1264191502.2224.2@antares> <4B5D4E56.3020902@grandegger.com>
	<1264451219.2315.1@antares>
In-Reply-To: <1264451219.2315.1@antares>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>,
	Devicetree Discussions <devicetree-discuss@lists.ozlabs.org>,
	"Ben Dooks \(embedded platforms\)" <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Albrecht Dreß wrote:
> Am 25.01.10 08:55 schrieb(en) Wolfgang Grandegger:
>> Albrecht Dreß wrote:
>>> Make the I2C adapter timeout configurable through a Device Tree
>>> property which gives the timeout in microseconds.
>>
>> My understanding is that software properties should not be defined via
>> the device tree. I think a sysfs entry is more appropriate.
> 
> Is the timeout really a /software/ property?  My feeling is that the
> timeout basically depends upon the bus clock and the chips attached to
> the bus.  Therefore, it is linked closer to the composition of the
> board's hardware as described in the device tree, than to any userland
> software.  Or am I totally wrong here?

Well, yes, it seems to be a border case.

Wolfgang.
