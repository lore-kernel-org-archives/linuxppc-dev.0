Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-311.bluehost.com (outbound-mail-311.bluehost.com
	[67.222.54.4]) by ozlabs.org (Postfix) with SMTP id 1EC70DE0D6
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Dec 2008 07:27:06 +1100 (EST)
Message-ID: <49441A98.1050104@dlasys.net>
Date: Sat, 13 Dec 2008 15:27:04 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Is anyone using the C67x00 USB Host ?
References: <49394978.10905@dlasys.net>
	<493D2B22.4000601@seznam.cz>	<493ED4B6.7010605@dlasys.net>
	<493F89F2.60702@seznam.cz>	<87iqpsme9j.fsf@macbook.be.48ers.dk>
	<493FD3EC.3060305@seznam.cz>	<87wse8m6p0.fsf@macbook.be.48ers.dk>
	<493FEFA7.9050703@seznam.cz>	<494401F3.2050005@dlasys.net>
	<87fxkrgawn.fsf@macbook.be.48ers.dk>
In-Reply-To: <87fxkrgawn.fsf@macbook.be.48ers.dk>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Korsgaard wrote:
>  David> But I still can not get host 1B working. Any sugestions as to
>  David> something I can look at ?
>
> Not right away. All the platforms I have been using have only used
> port 1A, so there could potentially be a mistake in the driver /
> firmware.
Thanks, even knowing that helps.
I have spent most of this morning soldering a wirewraped USB connector
to my board.
If the interrupt firware was wrong, maybe somebody switched D+ and D- or
maybe I can connect to 2a and use it as a 2nd host.
Unfortunately no joy.
As best as I can tell the USB system is finding 1A,1B, amd 2A - ls
/dev/usbdev* lists
usbdev1.1 usbdev1.1_ep00 usbdev1.1_ep81 usbdev1.2 usbdev1.2_ep00
usbdev1.2_ep01 usbdev1.2_ep81 usbdev2.1 usbdev2.1_ep00 usbdev2.1_ep81

How about anybody used 2A or 2B ?
Anybody know of a Xilinx/Cypres test app that tests hosts on anything
but 1A ?




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
