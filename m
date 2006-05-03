Return-Path: <kimmo.surakka@oxinst.fi>
Received: from imap.oxinst.fi (unknown [62.236.216.24])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3E25767A5B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 23:27:00 +1000 (EST)
Received: from [62.236.216.25] (helo=s5mtx04.metorex.fi)
	by imap.oxinst.fi with smtp (Exim 3.35 #1 (Debian))
	id 1FbH0l-0001IE-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 03 May 2006 16:03:23 +0300
From: Kimmo Surakka <kimmo.surakka@oxinst.fi>
To: linuxppc-embedded@ozlabs.org
Subject: MPC5200 I2C unstable?
Date: Wed, 3 May 2006 16:08:47 +0300
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200605031608.47579.kimmo.surakka@oxinst.fi>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I'm using a MPC5200 based board (namely TQM5200) and the 
linuxppc_2_4_devel-2005-10-25-1440 kernel from denx.de. To get the serial 
ports more stable, I've applied the serial port patch by Achim Machura (can 
be found in 
http://marc.theaimsgroup.com/?l=linuxppc-embedded&m=112901824515097&w=2). The 
patch needed small adjustments, but nothing too large -- mostly different 
line numbers.

Also, to get the first I2C interface to work, I've had to change the file 
drivers/i2c/i2c-tqm5200.c followingly:

-#define MPC5xxx_I2C1_ENABLE    0       /* Disable  */
+#define MPC5xxx_I2C1_ENABLE    1       /* Enable   */

The code compiles OK, but the I2C bus gets stuck after a short while. Has 
anyone else experienced something similar? I tried to Google for information 
but didn't find anything relevant. Maybe I just didn't know the right 
keywords to search for?

Thanks in advance,

Kimmo Surakka

This message has been scanned by F-Secure Anti-Virus

###  OXFORD INSTRUMENTS   http://www.oxford-instruments.com/  ###

Unless stated above to be non-confidential, this E-mail and any
attachments are private and confidential and are for the addressee
only and may not be used, copied or disclosed save to the addressee.
If you have received this E-mail in error please notify us upon receipt
and delete it from your records. Internet communications are not secure
and Oxford Instruments is not responsible for their abuse by third
parties nor for any alteration or corruption in transmission.
