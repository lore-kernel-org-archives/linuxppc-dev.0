Return-Path: <jourdan@enib.fr>
Received: from alto.enib.fr (alto.enib.fr [195.221.233.5])
	by ozlabs.org (Postfix) with ESMTP id ED8EC67A3E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Jun 2006 01:39:03 +1000 (EST)
Message-ID: <2586.194.3.133.184.1149175949.squirrel@webmail.enib.fr>
In-Reply-To: <20060530203221.236923525D9@atlas.denx.de>
References: Your message of "Tue, 30 May 2006 11:39:23 +0200."            
	<1664.194.3.133.184.1148981963.squirrel@webmail.enib.fr>
	<20060530203221.236923525D9@atlas.denx.de>
Date: Thu, 1 Jun 2006 17:32:29 +0200 (CEST)
Subject: Re: Can't get CoralP drivers to work (fixed)
From: jourdan@enib.fr
To: "Wolfgang Denk" <wd@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
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

Hello guys

I had time to dig into the kernel code and I discovered the origin of my
problem. As I said in a previous post, we use a custom processor card
based on a mpc8270. In the initialisation of our board was missing the
following line :

conswitchp = &dummy_con;

That's all !

Now it works fine.

I still have a little problem : video output signals seems to be very low.
I have to set the maximum contrast and luminosity to see something. I
tried on different monitors, the problem is the same.

The board is configured to use the rgb analog signals from the coral, not
from the dac.

Are there any jumpers or register to tweak the video signal levels ? I
can't find it in the hardware manual...
