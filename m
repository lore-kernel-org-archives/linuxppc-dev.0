Return-Path: <SEW_S@tqs.de>
Received: from mail.tqs.de (mail.tqs.de [62.157.136.17])
	by ozlabs.org (Postfix) with ESMTP id 2523BDDF26
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Jul 2008 23:15:23 +1000 (EST)
Message-ID: <48848599.2090707@tqs.de>
Date: Mon, 21 Jul 2008 14:48:25 +0200
From: Jens Gehrlein <sew_s@tqs.de>
MIME-Version: 1.0
To: mahendra varman <mahendravarman15@gmail.com>
Subject: Re: No filesystem could mount root
References: <4ac2955e0807180700u6184562duc128049245e37fdc@mail.gmail.com>	<790896390807190452n7197924ma07bfd4c3431eb89@mail.gmail.com>
	<4ac2955e0807190602g4dcf7ddauc07dd8441ef678cc@mail.gmail.com>
In-Reply-To: <4ac2955e0807190602g4dcf7ddauc07dd8441ef678cc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi,

mahendra varman schrieb:
> setenv bootargs console=ttyS0,57600 root=/dev/nfs
> nfsroot=192.168.0.6:/root/FILESYSTEM/target/target-minimal
> ip=192.168.0.200:192.168.0.6:192.168.0.1:255.255.255.0::eth0

I had a similar problem. Setting the rw flag helped, e.g.
... root=/dev/nfs rw nfsroot ...
                   ^^
Kind regards,
Jens
