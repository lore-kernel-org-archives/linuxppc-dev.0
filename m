Message-ID: <40E9CF45.7020009@246tNt.com>
Date: Mon, 05 Jul 2004 23:59:33 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: iida <iida@ztec.com.br>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bestcomm and i2c
References: <40E9C6D3.5020708@ztec.com.br>
In-Reply-To: <40E9C6D3.5020708@ztec.com.br>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


iida wrote:

 >
 > I  am to use the bestcomm API with 2.4.25 denx to control the i2c

Are you really sure you want to do that ?
Your peripheral really require such I2C bandwidth that you just can't
use the actual code ?

 > Someone already used it ? Could provide a example /

Well, my last attempt was just to use interrupt to know when a
transfer was done instead of busy waiting. And I never got any
interrupts for the second I2C controller ( the one wired on the
lite5200 board ) unless I init both I2C controllers. I haven't yet
figured why ...

To get back at your original question, IIRC the BestCommAPI
package(Some big zip freescale will send you if you ask several times
;) ) has some code example of all devices, somewhere in a "validation"
directory. I can't send it, it's (c) Freescale.

Sylvain


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
