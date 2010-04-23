Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 68A90B7C48
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Apr 2010 07:54:21 +1000 (EST)
Message-ID: <4BD21709.7040500@mlbassoc.com>
Date: Fri, 23 Apr 2010 15:54:17 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: Initcall ordering
References: <4BD1C317.5000909@mlbassoc.com>
In-Reply-To: <4BD1C317.5000909@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/23/2010 09:56 AM, Gary Thomas wrote:
> I'm having trouble with the I2C devices on my 8347 platform.
> The problem is that I2C device probe() functions are only called
> once, as the I2C bus is being initialized (in this case fsl_i2c_init())
> I have 2 devices on this bus, one device gets it's initcall
> before fsl_i2c_init, the second one does not :-( This means
> that the second device is never probed.
>
> What can I do about this? Has the problem been seen before?
> I can provide more data, as required.
>
> note: I'm currently using 2.6.28, but I will be moving to 2.6.32
> soon in case it matters, but I'd rather find/understand/fix this
> in 2.6.28 if possible.

A possibly related question: how can I2C devices work as
modules when the device address + probe info is in the device
tree?  Given the behaviour I'm seeing (I2C device probes only
happen when the bus is enumerated), how is this supposed to
work?

... maybe I'm missing something fundamental?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
