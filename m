Return-Path: <MichaelGalea@ruggedcom.com>
Received: from rcserver3.ruggedcom.local (mail.ruggedcom.com [204.50.190.93])
	by ozlabs.org (Postfix) with ESMTP id 342DCDDDEA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Jun 2008 00:38:21 +1000 (EST)
Received: from michaelgalea.eng.lan (michaelgalea.eng.lan [10.128.10.10])
	by rceng01.eng.lan (Postfix) with ESMTP id 2EC501BFFF
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jun 2008 10:38:20 -0400 (EDT)
Received: from localhost ([127.0.0.1] ident=michaelgalea)
	by michaelgalea.eng.lan with esmtp (Exim 4.69)
	(envelope-from <michaelgalea@ruggedcom.com>) id 1KBscH-0008Q2-Gc
	for linuxppc-embedded@ozlabs.org; Thu, 26 Jun 2008 10:38:29 -0400
Message-ID: <4863A9E5.7020706@ruggedcom.com>
Date: Thu, 26 Jun 2008 10:38:29 -0400
From: Michael Galea <michaelgalea@ruggedcom.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: GPIO on 8360 from dts par_io?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm on 2.6.24 and need to get some GPIOs up and running on my 8360.  I 
think one way I can do it is to modify my dts to add to a pio to my 
par_io node, find it with of_find_node_by_name and install it with 
par_io_of_config.

1) Is this the best way to do the job?  booting-without-of doesn't have 
much advice for me..
2) Now that I have the GPIOs up, what can I use the get and set them 
from the kernel?

I understand GPIO management is coming/here in later kernels but I need 
to stick to 2.6.24 for the time being.

Thanks
