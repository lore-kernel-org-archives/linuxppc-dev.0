Return-Path: <neko@genesi-usa.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.27])
	by ozlabs.org (Postfix) with ESMTP id A386BDDDE3
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Nov 2008 05:23:37 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 9so3044467qwb.15
	for <linuxppc-dev@ozlabs.org>; Tue, 04 Nov 2008 10:23:35 -0800 (PST)
Message-ID: <49109323.2040603@genesi-usa.com>
Date: Tue, 04 Nov 2008 12:23:31 -0600
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Ren=E9_B=FCrgel?= <r.buergel@unicontrol.de>
Subject: Re: [PATCH V2] workaround for mpc52xx erratum #364 (serial may not
	be reset in break state)
References: <490F51E7.3020309@unicontrol.de>	<fa686aa40811031255w3d9a065dgb0eb7ad4b26c9651@mail.gmail.com>
	<4910274E.5030305@unicontrol.de>
In-Reply-To: <4910274E.5030305@unicontrol.de>
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
> But as the serial driver is also used for the MPC5121, we may have to 
> distinguish anyway. Does anyone have the possibility to test if the bug 
> in still present  on MPC5121?

Tell us what to do to get it to occur and what we're looking for and we
have a bunch of boards at Genesi, someone will find the time to test it
(if not them, then me :)

Right now I'm having a hell of a time getting a 2.6.27.x kernel running
on it though, some driver support is still missing from mainline making
it just that little bit extra frustrating to work with.. (if you're
using the system over a serial console, how are you supposed to test
serial port operation? USB doesn't work in >2.6.24 so I guess I have to
hope netconsole works :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
