Return-Path: <jacmet@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id 6304BDDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jun 2008 18:55:41 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1326593fga.39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 04 Jun 2008 01:55:39 -0700 (PDT)
To: swamydp <swamydp@gmail.com>
Subject: Re: linux 2.6 hangs at __delay function on Viretx 4 board
References: <17222725.post@talk.nabble.com>
	<20080514150139.E258D8D006F@mail70-va3.bigfish.com>
	<17276753.post@talk.nabble.com>
	<20080516162807.2132E181804D@mail89-sin.bigfish.com>
	<17454696.post@talk.nabble.com> <17482754.post@talk.nabble.com>
	<20080528140800.9ACE756007F@mail97-wa4.bigfish.com>
	<17638198.post@talk.nabble.com>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Wed, 04 Jun 2008 10:55:34 +0200
In-Reply-To: <17638198.post@talk.nabble.com> (swamydp@gmail.com's message of
	"Tue\, 3 Jun 2008 20\:00\:30 -0700 \(PDT\)")
Message-ID: <87tzg97f5l.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "swamydp" == swamydp  <swamydp@gmail.com> writes:

 swamydp> Hi John

 swamydp> I am using UARTLITE as serial console. I do not have license
 swamydp> for UART 16550.  I have enabled the drivers for uartlite in
 swamydp> menuconfig while configuring the kernel. I have tested all
 swamydp> combinations for the kernel command line - tty0, ttyUL0,
 swamydp> ttyl0, ttyS0 but could not get uartlite to output kernel
 swamydp> printk messages.

Correct syntax is console=ttyUL0

 swamydp> Since I am using uartlite , the following settings are
 swamydp> turned off in menuconfig

 swamydp> CONFIG_SERIAL_8250=n
 swamydp> CONFIG_SERIAL_8250_CONSOLE=n

Do you have console on uartlite (CONFIG_SERIAL_UARTLITE_CONSOLE)
enabled?

-- 
Bye, Peter Korsgaard
