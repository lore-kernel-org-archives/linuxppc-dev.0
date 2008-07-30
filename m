Return-Path: <timur.tabi@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.239])
	by ozlabs.org (Postfix) with ESMTP id 723ECDE3DF
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 23:00:07 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so1492wra.1
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jul 2008 06:00:05 -0700 (PDT)
Message-ID: <ed82fe3e0807300600n3f91a57bl823f639700d53a11@mail.gmail.com>
Date: Wed, 30 Jul 2008 08:00:05 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Jochen Friedrich" <jochen@scram.de>
Subject: Re: I2C node in device tree breaks old-style drivers
In-Reply-To: <48904863.7050902@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <488F72C8.8010909@freescale.com> <48904863.7050902@scram.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 30, 2008 at 5:54 AM, Jochen Friedrich <jochen@scram.de> wrote:
> Hi Timur,
>
>> So my conclusion is that specifying an I2C node in the device tree *requires*
>> that the driver be new-style.  Is there any way we can fix this?  I'm not going
>> to have time to update the CS4270 driver to a new-style interface before the
>> 2.6.27 window closes.
>
> This conclusion is correct. One possible way to fix this is to add support for
> blacklisting to drivers/of/base.c (untested):

No need.  I posted a patch to alsa-devel that makes the CS4270 a
new-style I2C driver.  I'd hate to think that my driver is the only
I2C driver used on PowerPC systems that was outdated. :-)


-- 
Timur Tabi
Linux kernel developer at Freescale
