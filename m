From: "Christophe Hannoyer" <christophe.hannoyer@men-france.fr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Baud rate for synchronous/asyncronous device driver.
Date: Mon, 30 Jun 2003 19:34:10 +0200
Message-ID: <KIEIKPGDNIEHFJHOLDKGKENACCAA.christophe.hannoyer@men-france.fr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I'm currently developing a device driver for Triple Communication
Controller. The diver managed two modes (asynchronous or synchronous)
because each serial line could be independently configured as synchronous or
asynchronous.

My request is concerning the configuration of the baud rate. In asynchronous
mode, there is no problem. I used the standard method (stty command for
example) and the standard predefine baud rates. Now I need in synchronous
mode to be able to configure the baud rate at any custom value (and not
predefined or fixed values).

One solution could be to use the spd_cust mode and the divisor. But with
this solution I can't set any values and I'm limited by pre-define values
too (baud_base, baud_base / 2, baud_base / 3 ...)
An other solution could be to use the baud_base to set the baud rate. I
don't like this one because it's not the standard use of baud_base and could
be disturbing for the next users of this driver.

Any solution will be welcome.

Best regards,

Christophe Hannoyer
MEN Mikro Elektronik
www.men-france.fr


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
