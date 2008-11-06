Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.25])
	by ozlabs.org (Postfix) with ESMTP id 4F145DDE04
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Nov 2008 09:41:08 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so503724qwb.15
	for <linuxppc-dev@ozlabs.org>; Thu, 06 Nov 2008 14:41:07 -0800 (PST)
Message-ID: <49137283.6040300@genesi-usa.com>
Date: Thu, 06 Nov 2008 16:41:07 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
Subject: Re: [PATCH V2] workaround for mpc52xx erratum #364 (serial may not
	be reset in break state)
References: <490F51E7.3020309@unicontrol.de>	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<4910274E.5030305@unicontrol.de> <49109323.2040603@genesi-usa.com>
	<491322DC.30208@unicontrol.de>
In-Reply-To: <491322DC.30208@unicontrol.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



René Bürgel wrote:
> Matt Sealey schrieb:
> 
> Alternativly, if you have more control over your serial device, just 
> send breaks continuously, open and close the serial port. Open it again 
> and receiving data fails, if the bug is present.

Well I have a couple systems I can write data from here, a little app to
send data really isn't that hard to come up with.

> Just btw: if USB is not working, did you miss the initialisation of the 
> USB-controller in your bootloader? I had similar problems getting from 
> 2.6.22 to 2.6.25 with my mpc5200.

Actually it's more to do with the fact that the patches to get USB working
(along with On The Go support) in the LTIB are quite intrusive, and written
for 2.6.24 - since then the USB cores seem to have been reshuffled so it
is far from a clean patch.

Someday I will get bored and port it to 2.6.28 :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
