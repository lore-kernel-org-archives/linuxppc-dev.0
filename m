Return-Path: <Orges.Furxhi@thyssenkrupp.com>
Received: from mail002.triaton.com (mail002.triaton.com [149.250.222.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail002.triaton.com",
	Issuer "TC TrustCenter for Security in Data Networks GmbH" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id B2F5167B59
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jul 2006 07:57:18 +1000 (EST)
Message-ID: <162B449665D6D643AD9E1D50FC6F4B14042F1C99@mdcexc05.na.ops.local>
From: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
To: "'Wolfgang Denk'" <wd@denx.de>, "Furxhi, Orges"
	<Orges.Furxhi@thyssenkrupp.com>
Subject: RE: USB flashdrive on Motorola MPC5200 (IceCube) board, linux ker
	nel 2.4.25 (DENX drop)
Date: Fri, 28 Jul 2006 16:57:11 -0500
MIME-Version: 1.0
Content-Type: text/plain
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

Mr, Denk

>But if you tested so many devices, and none of them is working,  then
>this is probably an indication of another problem.

It might be, but I can not figure out what it is. I am hoping it is just a
kernel configuration mater.

>Do you have  a  chance  to  try  a  different  board?  Did  you  ever
>succesfully  use  *any*  USB  device  on your board? Maybe there is a
>hardware problem on your system.

I just have one icecube board (Lite5200 Ver 2.0), and I have 4 of our own
custom boards designed after the icecube. Right now I am testing on the
icecube board. I tried our boards but usb as mass storage is not working
there either.  

>Ummm... stupid question: is the green LED behind the USB connector on
>your board on or off?

There is one and it was off, I shorted out R164 and the led came on. Our
custom board takes care of this as well 


Which defconfig file should I use? 
I just tried the icecube_5200_CoralP_defconfig file but now the board is not
booting; it hangs right after this message:

"Uncompressing Kernel Image ... OK"


Thanks, 

Orges

PS.
>Argh... your message is very difficult to read, as there is no difference
>between your text and mine.
I assumed that outlook would do it automatically, but apparently it did not,
sorry about that.  

>Also, please don't send separate mesages to the original  poster  and the
>mailing list; use Cc: instead.
I hit "reply" instead of "reply all" by mistake; sorry about that too, I
will not happen again.
