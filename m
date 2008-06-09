Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 577C1DDF04
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 18:32:59 +1000 (EST)
Message-ID: <484CEA9C.7010505@grandegger.com>
Date: Mon, 09 Jun 2008 10:32:28 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH v2] [NAND] driver extension to support NAND on TQM85xx
	modules
References: <4847A8DA.6010406@grandegger.com>
	<1212825701.32207.403.camel@pmac.infradead.org>
In-Reply-To: <1212825701.32207.403.camel@pmac.infradead.org>
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

David Woodhouse wrote:
> On Thu, 2008-06-05 at 10:50 +0200, Wolfgang Grandegger wrote:
>> [NAND] driver extension to support NAND on TQM85xx modules
>>
>> This patch extends the FSL UPM NAND driver from Anton Vorontsov to
>> support NAND on the TQM85xx modules. Unfortunately, the hardware does
>> not support the R/B pins of the NAND chip and therefore the specified
>> maximum delay time must used. It therefore re-introduces the chip-delay
>> property.
>>
>> Note: this patch is based on various patches from  Anton Vorontsov posted
>>       to this list:
>>
>>       http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055587.html.
> 
> Do you also want me to apply that patch (on which this one depends)?
> It says 'Signed-off-by: not yet' ...
> 
> You should probably comment on the removal of the OF_GPIO dependency. It
> looks fine, since the relevant functions all get stubbed out and will do
> the right thing, but it's worth a comment in the commit text.

I just sent v3 of this patch with some better description.

Thanks,

Wolfgang.
