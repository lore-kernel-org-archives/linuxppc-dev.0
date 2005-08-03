Return-Path: <rupeshs@myw.ltindia.com>
Received: from mywsmtp.ltindia.com (unknown [203.199.60.127])
	by ozlabs.org (Postfix) with SMTP id 39BC567E6C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 Aug 2005 13:54:39 +1000 (EST)
Received: (from EMAIL [192.168.172.1])
	by mywsmtp.ltindia.com (SMSSMTP 4.0.0.59) with SMTP id
	M2005080309050329705
	for <linuxppc-embedded@ozlabs.org>; Wed, 03 Aug 2005 09:05:03 +0530
Message-Id: <s2f08948.039@EMAIL>
Date: Wed, 03 Aug 2005 09:06:52 +0530
From: "Rupesh S" <rupeshs@myw.ltindia.com>
To: <ktdann@gmail.com>,<linuxppc-embedded@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: Issue with running depmod after cross compiling
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Daniel,

Assuming your kernel is 2.6 based, you might want to try module-init-tools =
version 3.2-pre7. Also, it would be better to have the existing depmod =
renamed as depmod.old. This is for the new depmod to use in case it fails =
to execute.

--
Rupesh S

>>> Daniel Ann <ktdann@gmail.com> 08/03/05 06:57AM >>>
Hey folks,

For certain, I understand why running make module_install fails if I
run it after cross compiling the kernel+module.
What I'm doing now is, I've just commented out the bit in Makefile
(where it exec's depmod), and everythings cool.

BUT, problem with this method is, I get none of the module.dep and
many related files for auto loading of module.

What would be considered reasonable if I was to solve this ?

Thanks for your thought on this in advance.

--=20
Daniel
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org=20
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
