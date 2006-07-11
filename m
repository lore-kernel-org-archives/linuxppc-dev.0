Return-Path: <rahul.theraja@gmail.com>
Received: from predator.gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id 3FE9D679E1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 19:30:00 +1000 (EST)
Received: from predator.gdatech.co.in (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id C693E1242DC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 14:59:34 +0530 (IST)
Received: from predator.gdatech.co.in ([192.168.0.3])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Propel SE relay 1.0.0.3430
	$Rev$) id r67b145934-00-2
	for linuxppc-embedded@ozlabs.org; Tue, 11 Jul 2006 14:59:34 +0530
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 47CD41242DA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Jul 2006 14:59:34 +0530 (IST)
Message-ID: <44B36F85.3010703@gmail.com>
Date: Tue, 11 Jul 2006 14:59:41 +0530
From: rahul <rahul.theraja@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>, ilugc@ae.iitm.ac.in
Subject: regarding lspci
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All

My target system is  powerpc , linux-2.6.11.
when i give the lspci in my target system , it says "can't find the 
command".
I have seen in the ramdisk directory, i could not see the lspci utility 
or pci utilities. Even in the busybox i could not find the utility.
In linux i have enabled the pci support.

How to get the utility to busybox. I have searched in the net but could 
not succeed.
Can anyone please help me in this regard. plz correct me if i am missing 
some basic configuration .

Thanks & Regards
Rahul
