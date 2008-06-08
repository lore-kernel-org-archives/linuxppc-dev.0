Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id A84A5DDF84
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Jun 2008 04:05:36 +1000 (EST)
Message-ID: <484C1F6C.9000108@grandegger.com>
Date: Sun, 08 Jun 2008 20:05:32 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2] [NAND] driver extension to support NAND on TQM85xx
	modules
References: <4847A8DA.6010406@grandegger.com>
	<1212825701.32207.403.camel@pmac.infradead.org>
	<20080607114438.GA23329@polina.dev.rtsoft.ru>
In-Reply-To: <20080607114438.GA23329@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Sat, Jun 07, 2008 at 09:01:41AM +0100, David Woodhouse wrote:
>> On Thu, 2008-06-05 at 10:50 +0200, Wolfgang Grandegger wrote:
>>> [NAND] driver extension to support NAND on TQM85xx modules
>>>
>>> This patch extends the FSL UPM NAND driver from Anton Vorontsov to
>>> support NAND on the TQM85xx modules. Unfortunately, the hardware does
>>> not support the R/B pins of the NAND chip and therefore the specified
>>> maximum delay time must used. It therefore re-introduces the chip-delay
>>> property.
>>>
>>> Note: this patch is based on various patches from  Anton Vorontsov posted
>>>       to this list:
>>>
>>>       http://ozlabs.org/pipermail/linuxppc-dev/2008-April/055587.html.
>> Do you also want me to apply that patch (on which this one depends)?
>> It says 'Signed-off-by: not yet' ...
> 
> Well, I have no objections to applying that patch, feel free to add my
> sign off. But if OF people will NAK the bindings, I'll have to bother you
> once again with the update to that driver. :-/
> 
> I've tried to push the bindings several times already, and always there
> were [absolutely legitimate] issues. The last RFC is here (along with
> other new bindings):
> 
> http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057244.html
> 
> so far no comments.. Probably a good sign. :-)

I see. I think I should then also post the bindings (update of
booting-without-of.txt) separately.

Wolfgang.
