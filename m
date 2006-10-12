Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 1FF6067C40
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 01:48:20 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GY2nC-00055o-Uk
	for linuxppc-embedded@ozlabs.org; Thu, 12 Oct 2006 17:48:18 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx I2C driver for linux 2.6?
References: <877iz5wo8q.fsf@sleipner.barco.com>
	<452E612D.1070301@ovro.caltech.edu>
Date: Thu, 12 Oct 2006 17:48:18 +0200
In-Reply-To: <452E612D.1070301@ovro.caltech.edu> (David Hawkins's message of
	"Thu, 12 Oct 2006 08:37:17 -0700")
Message-ID: <87u029v8l9.fsf@sleipner.barco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>>> "DH" == David Hawkins <dwh@ovro.caltech.edu> writes:

Hi,

DH> Peter, whats the name of the driver in mainline?  (Denx git or
DH> kernel.org?)

Kernel.org - drivers/i2c/busses/i2c-ocores.c

Also take a look at Documentation/i2c/busses/i2c-ocores.

DH> I want to use the opencore IP in a memory mapped FPGA (Altera
DH> though), so would like to take a look at your driver.

You're welcome. It should be pretty easy to get going (just provide a
platform device with addr/irq).

-- 
Bye, Peter Korsgaard
