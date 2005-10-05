Return-Path: <KokHow.Teh@marconi.com>
Received: from smtpoutuk01.marconi.com (smtpoutuk01.marconi.com
	[128.87.251.112]) by ozlabs.org (Postfix) with ESMTP id E624868423
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Oct 2005 12:36:07 +1000 (EST)
To: Vitaly Bordug <vbordug@ru.mvista.com>, david.jander@protonic.nl,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
From: "KokHow Teh" <KokHow.Teh@marconi.com>
Date: Wed, 5 Oct 2005 10:36:00 +0800
Message-ID: <OF0BB1D8FC.27908478-ON48257091.000E28F8@uk.marconicomms.com>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Subject: Re: serial console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi;
      I have tried with 4 types of command lines with my linux kernel with
devfs and serial device compiled in and none gives me the desired results:

(1)   console=tts/0,115200n8 OR console=ttyCPM0,115200n8

      no serial console output at all during boot time but it gives me
login prompt at the end.

(2)   without "console=" OR console=ttyS0,115200n8

      serial console output fine during bootup but only until the point
when it prints out "Freeing unused kernel memory: 232k init 4k prep". After
that, the serial console output is garbled. No login prompt.

      So this has not solved my problem. I need more advice. Here are some
more questions and observations:

(1)   David Jander's comment:

I don't know exactly what I am talking about right now, but the string
"tts/0"
in the console-line sounds suspicious to me. AFAIK when using devfs still
device names on the kernel-commandline have to be old-style.
Just a guess: try using "console=ttyS0,115200n8" and see if this helps.

      Is it confirmed that kernel-commandline has to be old-style even
though the kernel is using devfs?

(2)   Vitaly Bordug's suggestion of using "console=ttyCPM0". May I know
where is ttyCPM0 defined and how is it bound to the serial console device
driver in the source?

      Thanks for any input and pointer.

Regards,
TEH
