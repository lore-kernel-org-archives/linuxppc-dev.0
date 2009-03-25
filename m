Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 66C8EDDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 02:25:59 +1100 (EST)
Message-ID: <49CA4D02.3080009@grandegger.com>
Date: Wed, 25 Mar 2009 16:25:54 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3 1/4] NAND: FSL-UPM: add multi chip support
References: <1237975701-23201-1-git-send-email-wg@grandegger.com>	<1237975701-23201-2-git-send-email-wg@grandegger.com>
	<20090325145719.GA32313@oksana.dev.rtsoft.ru>
In-Reply-To: <20090325145719.GA32313@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Anton,

Anton Vorontsov wrote:
> Hi Wolfgang,
> 
> On Wed, Mar 25, 2009 at 11:08:18AM +0100, Wolfgang Grandegger wrote:
>> This patch adds support for multi-chip NAND devices to the FSL-UPM
>> driver. This requires support for multiple GPIOs for the RNB pins.
>> The NAND chips are selected through address lines defined by the
>> FDT property "chip-offset".
>>
>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>> ---
> 
> Some cosmetic issues are still there...

Normally I use checkpatch.pl to validate my patches, but ... grrr,
sorry. It finds all the obvious issues you reported.

[snip]

> When the cosmetic issues are fixed, I'll readily ack this patch.

Thanks, will resend a.s.a.p.

Wolfgang.
