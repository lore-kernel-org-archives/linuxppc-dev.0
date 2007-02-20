Return-Path: <poseidon21@post.sk>
Received: from otrok.post.sk (otrok.post.sk [85.248.69.172])
	by ozlabs.org (Postfix) with ESMTP id 3D034DDDEF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Feb 2007 05:21:24 +1100 (EST)
Message-ID: <45DB3249.000001.09134@kamasutra>
Mime-Version: 1.0
Content-Type: Text/Plain;
	Charset = "ISO-8859-2"
From: Ladislav Klenovic <poseidon21@post.sk>
To: <linuxppc-embedded@ozlabs.org>
Subject: strange insmod behaviour
Date: 20 Feb 2007 18:39:21 +0100 (CET)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there,
I have upgraded my external drivers from 2.6.16.20 to 2.6.20 kernel. 
Now a bit strange behaviour has occured while module inserting. 
I can not insert module because this error occur: \"Can\'t insert module: File exists -1\". 
But I am pretty sure that module was not inserted before. It is concretely i2c adapter+8xx_algorithm driver.

Can someone explain me this strange behaviour, how kernel knows whether the 
module is or isn\'t loaded? Again, everything works fine with 2.6.16.20 kernel.

Regards,
Ladislav.

  


__________
http://sport.sme.sk - Najkomplexnej¹ie informácie zo ¹portu
