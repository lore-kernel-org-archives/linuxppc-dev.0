Message-ID: <40AB303B.4090709@bluewin.ch>
Date: Wed, 19 May 2004 12:00:27 +0200
From: Wolfgang Grandegger <wolfgang.grandegger@bluewin.ch>
MIME-Version: 1.0
To: Steve Kaiser <steven.kaiser@ucr.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200 LEDs
References: <200405181550.AYL88709@sentry.ucr.edu>
In-Reply-To: <200405181550.AYL88709@sentry.ucr.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On 05/18/2004 05:50 PM Steve Kaiser wrote:
> Before I plow into it, I ask for your advice.  What is the best way to turn
> on/off the status LEDs on the Motorola Lite5200 ("IceCube") board?
>
> Although experienced with embedded micros & DSPs in general, I am a newbie to
> Linux and the MPC5200.
> Thanks to Wolfgang for the most excellent U-Boot and ELDK.  With these tools,
> I have compiled a 2.4.25 kernel and have it running from either RAM or Flash
> in my 5200 IceCube.  I can insmod a simple "hello world" module on my target.
> That's where I'm at.  I figure the next exciting step is to turn LEDs on &
> off.  Right?  What's the best/correct way in the Linux tradition?  Any tips
> are welcome.

I have recently started to port/develop a little digital I/O driver for
the Icecube for a Linux driver training course. It allows to configure
some port pins for output and input with interrupts and with a few
jumper cables you can toggle the pins and trigger interrupts. It's still
in a preliminary state. Nevertheless I could send it to you in a private
mail in case you are interested.

Wolfgang.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
