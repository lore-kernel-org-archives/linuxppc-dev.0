Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f123.google.com (mail-qy0-f123.google.com
	[209.85.221.123]) by ozlabs.org (Postfix) with ESMTP id D9C51DDECF
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 00:39:50 +1000 (EST)
Received: by mail-qy0-f123.google.com with SMTP id 29so6111563qyk.17
	for <linuxppc-dev@ozlabs.org>; Fri, 01 May 2009 07:39:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9e4733910905010739q4038555ck211ee61b9b443f01@mail.gmail.com>
References: <49FAF351.4010409@mlbassoc.com>
	<9e4733910905010739q4038555ck211ee61b9b443f01@mail.gmail.com>
Date: Fri, 1 May 2009 10:39:49 -0400
Message-ID: <9e4733910905010739p6c4fddf3oab1b583b72df4eeb@mail.gmail.com>
Subject: Re: Using archaic I2C with OF
From: Jon Smirl <jonsmirl@gmail.com>
To: Gary Thomas <gary@mlbassoc.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 1, 2009 at 10:39 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Fri, May 1, 2009 at 9:04 AM, Gary Thomas <gary@mlbassoc.com> wrote:
>> I'd like to use an existing I2C driver (a touchscreen device)
>> with my 834x based platform. =A0How do I arrange to provide
>> platform data (i2c_client->dev.platform_data) from my OF world?
>
> It is easier to convert the i2c driver to work in the current model.

All in-tree drivers have already been converted.

>
> --
> Jon Smirl
> jonsmirl@gmail.com
>

--=20
Jon Smirl
jonsmirl@gmail.com
