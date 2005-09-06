Return-Path: <clemens.koller@anagramm.de>
Received: from moutvdomng.kundenserver.de (moutvdom.kundenserver.de
	[212.227.126.249]) by ozlabs.org (Postfix) with ESMTP id 9682E68077
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Sep 2005 02:09:30 +1000 (EST)
Message-ID: <431DBF34.2040000@anagramm.de>
Date: Tue, 06 Sep 2005 18:09:24 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
References: <20050906145405.BFEC5352661@atlas.denx.de>
In-Reply-To: <20050906145405.BFEC5352661@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Regarding the PPC board bringup with Linux 2.6 kernel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Vinay

Please reply to the list also!

I can guess your problem, but you should give more
information about your system i.e.
Processor / Board / Kernel version, ...

vinay hegde wrote:
> I do not have the board in my possesion. Actually, I
> am using the board through virtual network. Hence, I
> am unable to use any of the debugging techniques
> (JTAG, logic analyzer etc) except going through the
> source code and printing some messages. 

Then you depend on the console output at least.
-> early printk.

> Also, how do I enable early printk option? I did not
> find any such option under kernel configuration.

i.e. if you use one of the latest 2.6 kernels,
turn on "Support for early boot texts over serial port"
(That's in in "Kernel hacking") 
Verify your console settings twice.

You can even start to poke out some characters manually
to the serial port to see if (where) it really hangs if
you cannot use or don't want to spend lots of money to
get a hw debugger just for this.

> And, thanks for referring me to the mailing
> addresses.  I will immediately subscribe to Ozlabs!

Read the list archives and the FAQ's mentioned
in here and ask google. You will get good answers there,
too!

Best greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
