Return-Path: <jfaslist@yahoo.fr>
Received: from smtp004.mail.ukl.yahoo.com (smtp004.mail.ukl.yahoo.com
	[217.12.11.35]) by ozlabs.org (Postfix) with SMTP id ABF8567A06
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 22:40:32 +1000 (EST)
Message-ID: <4458A321.1030206@yahoo.fr>
Date: Wed, 03 May 2006 14:33:37 +0200
From: jfaslist <jfaslist@yahoo.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: mpc8270 : i2c support
Content-Type: text/plain; charset=us-ascii; format=flowed
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
We have designed a system using a mpc8270 cpu. The firmware we 
use is u-boot and we can access all our i2c devices from u-boot.

But when we try to access i2c devices from under linux 2.6 using 
the /dev/i2c-0 special file we get an ENODEV on opening that 
file. I think it is because we lack an adapter driver.

If I look in the official kernel, it looks like the adapter 
driver for the mpc8270 i2c system is 
./drivers/i2c/busses/i2c-mpc.c. Is this correct?

Why is this driver registering as a platform driver and not as a 
i2c bus driver?

In DENX ELDK there is also a i2c-mpc8260.c, but we couldn't get 
that to work either.

What should I do to be able to access i2c devices using the 
/dev/i2c-0 file? I feel I need to modify the i2c adapter driver 
to follow the driver model, but in what ways?

Thx for any help,
-jf simon

	

	
		
___________________________________________________________________________ 
Faites de Yahoo! votre page d'accueil sur le web pour retrouver directement vos services préférés : vérifiez vos nouveaux mails, lancez vos recherches et suivez l'actualité en temps réel. 
Rendez-vous sur http://fr.yahoo.com/set
