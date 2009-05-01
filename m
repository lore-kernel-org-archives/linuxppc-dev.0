Return-Path: <gary@mlbassoc.com>
Received: from mail.chez-thomas.org (hermes.mlbassoc.com [76.76.67.137])
	by ozlabs.org (Postfix) with ESMTP id 8CBE7DDDB6
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 00:50:47 +1000 (EST)
Message-ID: <49FB0C3B.3000209@mlbassoc.com>
Date: Fri, 01 May 2009 08:50:35 -0600
From: Gary Thomas <gary@mlbassoc.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Using archaic I2C with OF
References: <49FAF351.4010409@mlbassoc.com>	
	<9e4733910905010739q4038555ck211ee61b9b443f01@mail.gmail.com>
	<9e4733910905010739p6c4fddf3oab1b583b72df4eeb@mail.gmail.com>
In-Reply-To: <9e4733910905010739p6c4fddf3oab1b583b72df4eeb@mail.gmail.com>
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

Jon Smirl wrote:
> On Fri, May 1, 2009 at 10:39 AM, Jon Smirl <jonsmirl@gmail.com> wrote:
>> On Fri, May 1, 2009 at 9:04 AM, Gary Thomas <gary@mlbassoc.com> wrote:
>>> I'd like to use an existing I2C driver (a touchscreen device)
>>> with my 834x based platform.  How do I arrange to provide
>>> platform data (i2c_client->dev.platform_data) from my OF world?
>> It is easier to convert the i2c driver to work in the current model.
> 
> All in-tree drivers have already been converted.

I'm looking at drivers/input/touchscreen/tsc2007.c (the one I need)
from Kumar's 'next' tree.  It most definitely still uses the old
model.

Can you suggest another place to look?

-- 
------------------------------------------------------------
Gary Thomas                 |  Consulting for the
MLB Associates              |    Embedded world
------------------------------------------------------------
