Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BC356DE1FB
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 05:02:16 +1100 (EST)
Message-ID: <472771A4.8010005@freescale.com>
Date: Tue, 30 Oct 2007 13:02:12 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alan Bennett <embedded@akb.net>
Subject: Re: Continued serial headaches
References: <bfa0697f0710301042j5d899790k753050f22079f3d6@mail.gmail.com>
In-Reply-To: <bfa0697f0710301042j5d899790k753050f22079f3d6@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Alan Bennett wrote:
> Am I missing something in the PRAM areas?
> SMC1 (ttyCPM0...)
>   e0008000 : 00c000e0 30300020 00000000 eefe3e7a
>   e0008010 : 00c07331 11b6b05f 30440000 07f4d082
>   e0008020 : 00e00003 746562ec d98ceffd 0dec67e3
>   e0008030 : df7b2db5 5f0bf2dc 00205ce8 00010000
>   e0008040 : 00000000 0000fc9d 00000000 d08a0000
>   e0008050 : 80008000 80008000 80008000 80008000
> SCC1
>   e0008000 : 00c000e0 30300020 00000000 eefe3e7a
>   e0008010 : 00c07331 11b6b05f 30440000 07f4d082
>   e0008020 : 00e00003 746562ec d98ceffd 0dec67e3
>   e0008030 : df7b2db5 5f0bf2dc 00205ce8 00010000
>   e0008040 : 00000000 0000fc9d 00000000 d08a0000
>   e0008050 : 80008000 80008000 80008000 80008000

I'm fairly sure you don't want SMC1 and SCC1 to have the same PRAM areas...

Assuming that was just a typo, I don't know what could be wrong.  You'll 
just have to debug it. :-)

-Scott
