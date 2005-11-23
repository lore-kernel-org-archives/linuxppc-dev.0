Return-Path: <jarno.manninen@tut.fi>
Received: from kivi.ton.tut.fi (kivi.ton.tut.fi [193.166.235.14])
	by ozlabs.org (Postfix) with ESMTP id 93753687D0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 02:55:16 +1100 (EST)
From: Jarno Manninen <jarno.manninen@tut.fi>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 23 Nov 2005 17:55:05 +0200
References: <000901c5f03c$5d4e8c60$6405a8c0@absolut>
In-Reply-To: <000901c5f03c$5d4e8c60$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200511231755.05549.jarno.manninen@tut.fi>
Cc: Absolut Hunter <absoluthunter@comcast.net>
Subject: Re: USB Keyboard Support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 23 November 2005 16:44, Absolut Hunter wrote:

> We are using a Sm501 video chip and also have that working now, I was
> hoping to get the USB Keyboard system and running so I could totally run
> the system without having to use the serial port as the stdin/stdout
> anymore.

Um. The serial port has its advantages when doing developement. If or when you 
crash the whole system you still have the output on the terminal. :)

> Anyone know what else is required in order to setup the USB keyboard as the
> input device when using a VGA console?

If you have frame buffer up and running then setting console=tty0 should be 
enough. Depending on your system you might want to check where 
the /dev/console points to. 

- Jarno
