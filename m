Return-Path: <albert_herranz@yahoo.es>
Received: from smtp142.mail.ukl.yahoo.com (smtp142.mail.ukl.yahoo.com
	[77.238.184.73]) by ozlabs.org (Postfix) with SMTP id 1D3F61007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 05:09:45 +1100 (EST)
Message-ID: <4B0D72E2.5010108@yahoo.es>
Date: Wed, 25 Nov 2009 19:09:38 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 04/19] powerpc: wii: device tree
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<fa686aa40911221518s5d82d5b4i8402a297d52a46d1@mail.gmail.com>
	<4B0AE865.4030502@yahoo.es>
	<49404.84.105.60.153.1259168264.squirrel@gate.crashing.org>
In-Reply-To: <49404.84.105.60.153.1259168264.squirrel@gate.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>>> +               i2c-video {
>>>> +                       #address-cells = <1>;
>>>> +                       #size-cells = <0>;
>>>> +                       compatible = "virtual,i2c-gpio";
>>> There isn't a documented binding for this.  Is there a driver for it?
>>>
>> I have a driver for it. But it isn't yet published.
> 
> I bet there already is a generic IIC-via-GPIOs driver that
> you could use.
> 

Yes, there is a platform driver for that.
I picked that, extracted the common code into a common file, converted the existing driver to use the common code, then created a new one for platform bindings using the common code again.

(Then added gpio_direction_is_output() to gpiolib and sda_enforce_dir() to i2c-gpio).

Thanks,
Albert
