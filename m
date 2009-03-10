Return-Path: <daniel.ng1234@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.238])
	by ozlabs.org (Postfix) with ESMTP id 35388DE03F
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 12:15:15 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so1778665rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Mar 2009 18:15:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4206182445660643B9AEB8D4E55BBD0A02B57F6F18@HERMES2>
References: <547eba1b0903042253i3a245eaw306fbddbf47b150b@mail.gmail.com>
	<4206182445660643B9AEB8D4E55BBD0A02B57F6F18@HERMES2>
Date: Tue, 10 Mar 2009 12:15:13 +1100
Message-ID: <547eba1b0903091815w5368012u2cf81954f6e20e2e@mail.gmail.com>
Subject: Re: GPIO and SPI on CPM2 (8260)?
From: Daniel Ng <daniel.ng1234@gmail.com>
To: "Stepanov, Sergej" <Sergej.Stepanov@ids.de>, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sergej,

On Fri, Mar 6, 2009 at 9:07 PM, Stepanov, Sergej <Sergej.Stepanov@ids.de> wrote:
> gpio - driver functions pretty well for a pin-setup, but uninitialized/unexported pins have undefined states

-did you achieve this using gpiolib.c? If not, then what files and
what kernel are you using? We are trying to get it working for 2.6.27.

> I found no spi-support for 8260-based boards with CPM2/1.

This is unfortunate. I guess this means SPI on these boards is not
used by many engineers...

> P.s. Have you seen cpm2-spi-support in u-boot?

No, sorry- not in u-boot.
