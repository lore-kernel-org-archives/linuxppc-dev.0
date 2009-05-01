Return-Path: <jonsmirl@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id 16ADFDDE0E
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 01:03:45 +1000 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1983239qwe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 01 May 2009 08:03:44 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <49FB0C3B.3000209@mlbassoc.com>
References: <49FAF351.4010409@mlbassoc.com>
	<9e4733910905010739q4038555ck211ee61b9b443f01@mail.gmail.com>
	<9e4733910905010739p6c4fddf3oab1b583b72df4eeb@mail.gmail.com>
	<49FB0C3B.3000209@mlbassoc.com>
Date: Fri, 1 May 2009 10:55:53 -0400
Message-ID: <9e4733910905010755g595d686fmf075a40d6012e3fc@mail.gmail.com>
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

On Fri, May 1, 2009 at 10:50 AM, Gary Thomas <gary@mlbassoc.com> wrote:
> Jon Smirl wrote:
>> On Fri, May 1, 2009 at 10:39 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
>>> On Fri, May 1, 2009 at 9:04 AM, Gary Thomas <gary@mlbassoc.com> wrote:
>>>> I'd like to use an existing I2C driver (a touchscreen device)
>>>> with my 834x based platform. =A0How do I arrange to provide
>>>> platform data (i2c_client->dev.platform_data) from my OF world?
>>> It is easier to convert the i2c driver to work in the current model.
>>
>> All in-tree drivers have already been converted.
>
> I'm looking at drivers/input/touchscreen/tsc2007.c (the one I need)
> from Kumar's 'next' tree. =A0It most definitely still uses the old
> model.
>
> Can you suggest another place to look?

Post this on the i2c list. Jean has made an effort to convert all
drivers. He must have missed that one.

>
> --
> ------------------------------------------------------------
> Gary Thomas =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =A0Consulting for the
> MLB Associates =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A0Embedded world
> ------------------------------------------------------------
>



--=20
Jon Smirl
jonsmirl@gmail.com
