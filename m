Return-Path: <jacmet@sunsite.dk>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id BF59467C1F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 01:24:55 +1000 (EST)
Received: from peko by sleipner.barco.com with local (Exim 4.60)
	(envelope-from <jacmet@sunsite.dk>) id 1GY2QX-0004x3-G9
	for linuxppc-embedded@ozlabs.org; Thu, 12 Oct 2006 17:24:53 +0200
From: Peter Korsgaard <jacmet@sunsite.dk>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Xilinx I2C driver for linux 2.6?
Date: Thu, 12 Oct 2006 17:24:53 +0200
Message-ID: <877iz5wo8q.fsf@sleipner.barco.com>
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

>>>>> "JBM" == Jean-Baptiste Maneyrol <MANE@teamlog.com> writes:

Hi,

JBM> Does anyone know if there is somewhere an i2c driver for the
JBM> Xilinx IIC IP working on linux 2.6?

Not afaik. We're using the OpenCores I2C controller instead which I in
the mean time have written a driver for (in mainline). The IP core is
afaik even smaller than the Xilinx controller.

-- 
Bye, Peter Korsgaard
