Return-Path: <graju@facetime.com>
Received: from postman.facetime.com (unknown [203.145.176.100])
	by ozlabs.org (Postfix) with ESMTP id BC2F6679EA
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 May 2005 17:40:05 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Mon, 9 May 2005 12:58:42 +0530
Message-ID: <83986B58C72FC447AAC98F916BAB6A5735D908@postman.facetime.com>
From: "Gopala Krishnam Raju" <graju@facetime.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Linuxppc-embedded Digest, montavista
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello Linux gurus

I have created a boot image for montavista doing the following way.

1. I did make mrproper.

2. Then make xconfig.

3. Selected the target architecture.

4. saved the configuration file and then

5. I have said make dep.  There was no errors it compiled well.

6. I ran make bzImage to get the bzImage.  It also went well without any =
errors.

7. got the bzImage in /linux..../arch/i386/boot/.  then i have copied =
this to /boot.

8. Made necessary changes in the grub.conf.

	but while booting i am getting an error saying that vfs: kernal panic.
	any ideas regarding this.

	i also tried with make modules. =20

	that also went well. but after starting with the new kernel it is =
giving error vfs: kernal panic.

	target and host are both platforms.=20

Regards

GGKRAJU
