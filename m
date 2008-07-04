Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.248])
	by ozlabs.org (Postfix) with ESMTP id D0D0CDDE3A
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 09:42:48 +1000 (EST)
Received: by ag-out-0708.google.com with SMTP id 8so8325489agc.0
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jul 2008 16:42:47 -0700 (PDT)
Message-ID: <fa686aa40807041642m1ecd1f8fr33382076ca5c11fa@mail.gmail.com>
Date: Fri, 4 Jul 2008 17:42:46 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Segher Boessenkool" <segher@kernel.crashing.org>
Subject: Re: [PATCH v2 3/5] of-bindings: Add binding documentation for SPI
	busses and devices
In-Reply-To: <1694b01b1b41f244e565298b430f021c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080703005749.26187.71719.stgit@trillian.secretlab.ca>
	<20080703010308.26187.23037.stgit@trillian.secretlab.ca>
	<1694b01b1b41f244e565298b430f021c@kernel.crashing.org>
Cc: david-b@pacbell.net, spi-devel-general@lists.sourceforge.net,
	fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 4, 2008 at 5:36 PM, Segher Boessenkool
<segher@kernel.crashing.org> wrote:
>> +    The SPI master node requires the following properties:
>> +    - #address-cells  - number of cells required to define a chip select
>> +                       address on the SPI bus.
>
> Hrm.  Should this (and "reg" in the child node) be required for SPI
> masters that have only one chip select?

I suppose it could be skipped, but I'd rather have it there for consistency

>
>> +    - max-speed       - (required) Maximum SPI clocking speed of device
>> in Hz
>
> The property name should include something "SPI", it's way too generic
> otherwise.

Good point; I'll change this to 'spi-max-speed'

>> +    - spi,cpol        - (optional) Device requires inverse clock polarity
>> +    - spi,cpha        - (optional) Device requires shifted clock phase
>
> Don't abbr the property names, there's nothing wrong with longer names.
> The names shouldn't start with "spi," either, "spi" isn't a vendor;
> how about "spi-inverse-clock-polarity" or similar?

Okay, but cpol and cpha are common abbreviations w.r.t. SPI devices.

>> +    - linux,modalias  - (optional, Linux specific) Force binding of SPI
>> device
>> +                       to a particular spi_device driver.  Useful for
>> changing
>> +                       driver binding between spidev and a kernel SPI
>> driver.
>
> This is a temporary workaround I hope?

Yeah, I'm kind of ashamed of this one.  I'll drop it.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
