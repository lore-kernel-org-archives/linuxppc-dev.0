Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id E1A98DDF36
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 09:10:37 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so91816anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 09 Jan 2008 14:10:35 -0800 (PST)
Message-ID: <fa686aa40801091410k5d83f124ve009c96683f78ad2@mail.gmail.com>
Date: Wed, 9 Jan 2008 15:10:35 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Joachim Meyer" <Jogi95@web.de>
Subject: Re: Linux for ml310
In-Reply-To: <524587219@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <524587219@web.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/9/08, Joachim Meyer <Jogi95@web.de> wrote:
> Hi
>
> I switched "Xilinx uartlite serieal port support" and "Support for console on Xilinxuartlite serialport" on and "8250/16550 and compatible serial support" off, in the kernel config.
> Then I removed the things I added in the xparameters.h and compiled successfully.
> But I have yet a few Questions:
>
> - What would you recommend to use? UART-Lite or a 16550 serial port. Can I get a console running on the RS232 Port of the Board with both possibilities?

if you don't need to change the baud rate at runtime then use the uartlite.

Console works on both.

>
> - Can you recommend anything for my next steps to get an running linux (rootfs usw.)? So far I oriented myself on the Klingauf page, but I think it is perhaps not the best one because its too old and some things will probably not work the way he did it anymore.

Use either ELDK or buildroot.  Personally, I'd like to be using
OpenEmbedded, but I haven't been successful with that yet.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
