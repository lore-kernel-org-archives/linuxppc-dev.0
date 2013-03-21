Return-Path: <cfoissac@studelec-sa.com>
Received: from madmax.studelec-sa.com (unknown [195.167.234.227])
 by ozlabs.org (Postfix) with ESMTP id 79DD92C0209
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 20:04:37 +1100 (EST)
Received: from localhost (madmax.studelec-sa.com [127.0.0.1])
 by madmax.studelec-sa.com (Postfix) with ESMTP id 796F93FE090
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 09:54:48 +0100 (CET)
Received: from madmax.studelec-sa.com ([127.0.0.1])
 by localhost (madmax.studelec-sa.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6jzvLSh0HLE5 for <linuxppc-dev@lists.ozlabs.org>;
 Thu, 21 Mar 2013 09:54:48 +0100 (CET)
Received: from [192.168.1.12]
 (AMontpellier-552-1-219-46.w86-202.abo.wanadoo.fr [86.202.74.46])
 by madmax.studelec-sa.com (Postfix) with ESMTPSA id ED8283FE08F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Mar 2013 09:54:47 +0100 (CET)
Message-ID: <514ACAD6.6010909@studelec-sa.com>
Date: Thu, 21 Mar 2013 09:54:46 +0100
From: CF Studelec <cfoissac@studelec-sa.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: MPC5121e, Linux, simple IO ports
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This is a simple board base on mpc5121e MCU.


Gpio is detected: kernel is compiled with its support - i got
gpiochip_find_base: found new base @224 in dmesg - on kernel 3.0.4.

 
But i'm unable to access it through /sys/class/gpio. I can successfully
export a pin (ie, if i type cat 224 > export, gpio224 is created), but i
can't successfully control it:

 

echo "out" > /sys/class/gpio/gpio224/direction

cat /sys/class/gpio/gpio224/value

0

echo 1 > /sys/class/gpio/gpio224/value

cat /sys/class/gpio/gpio224/value

0

 

My need is a simple chipselect (well, 3 chipselect exactly ), for a
custom design. Running linux is mandatory. I suspect the MPC5121e to be
in the bad function mode, so:

- does anyone knows how to change mode ? What register can i acces and
how ? does it worths a try ?

- does anyone successfully performed simple IO control ?

 

Last thing, i have tryed to access internal registers through /dev/mem,
but no success. There are very few ressources available for this
microcontroler, but i'm stick to it. Perhaps anybody knows how to access
(read) internal registers with /proc or sys-fs ?

 

Thank you for your help.
