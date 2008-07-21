Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 14B0EDDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jul 2008 17:16:11 +1000 (EST)
Message-ID: <4884383D.3060203@coritel.it>
Date: Mon, 21 Jul 2008 09:18:21 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: mahendra varman <mahendravarman15@gmail.com>
Subject: Re: No filesystem could mount root
References: <4ac2955e0807180700u6184562duc128049245e37fdc@mail.gmail.com>	<790896390807190452n7197924ma07bfd4c3431eb89@mail.gmail.com>
	<4ac2955e0807190602g4dcf7ddauc07dd8441ef678cc@mail.gmail.com>
In-Reply-To: <4ac2955e0807190602g4dcf7ddauc07dd8441ef678cc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: selvamuthukumar v <v.selvamuthukumar@gmail.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

mahendra varman ha scritto:
>> There are no messages from the kernel that it's trying NFS. You can
>> check the boot arguments you are passing to the kernel.
>>
> 
> The boot arguments are passed correctly only.
> 
> setenv bootargs console=ttyS0,57600 root=/dev/nfs
> nfsroot=192.168.0.6:/root/FILESYSTEM/target/target-minimal
> ip=192.168.0.200:192.168.0.6:192.168.0.1:255.255.255.0::eth0
> 
> still Iam getting the above said error
> 
> Any clue??
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
Sometimes ago I had the same problem, I don't exactly remember the 
problem, but it was related to the NFS server configuration. Check it out.

Regards,

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
