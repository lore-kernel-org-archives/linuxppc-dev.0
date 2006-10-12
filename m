Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.ovro.caltech.edu",
	Issuer "mail.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 20A2867CB6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Oct 2006 01:37:45 +1000 (EST)
Message-ID: <452E612D.1070301@ovro.caltech.edu>
Date: Thu, 12 Oct 2006 08:37:17 -0700
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: Xilinx I2C driver for linux 2.6?
References: <877iz5wo8q.fsf@sleipner.barco.com>
In-Reply-To: <877iz5wo8q.fsf@sleipner.barco.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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



> Not afaik. We're using the OpenCores I2C controller instead which I in
> the mean time have written a driver for (in mainline). The IP core is
> afaik even smaller than the Xilinx controller.
> 

Peter, whats the name of the driver in mainline?
(Denx git or kernel.org?)

I want to use the opencore IP in a memory mapped
FPGA (Altera though), so would like to take a look
at your driver.

Cheers,
Dave
