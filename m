Return-Path: <jjboor@aimsys.nl>
Received: from mta-fe.casema.nl (cas-mta2-fe.casema.nl [83.80.1.24])
	by ozlabs.org (Postfix) with ESMTP id 9442F67A76
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 06:31:22 +1000 (EST)
In-Reply-To: <000001c65d85$5e699890$5201a8c0@GEG2400>
References: <000001c65d85$5e699890$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <2A6845D3-BD54-4407-9CC7-B053622E2E20@aimsys.nl>
From: Jaap-Jan Boor <jjboor@aimsys.nl>
Subject: Re: NAND and JFFS2 supports in Linux 2.4
Date: Tue, 11 Apr 2006 22:06:06 +0200
To: Laurent Lagrange <lagrange@fr.oleane.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Laurent,

Take a look at the 2.4 http://www.denx.de kernel, it has NAND and jffs2
support.

Jaap-Jan

On 11-apr-2006, at 18:31, Laurent Lagrange wrote:

>
> Hello,
>
> I work on a custom 82xx board with a NAND flash :
> NAND device: Manufacturer ID: 0xec, Chip ID: 0xf1 (Samsung NAND  
> 128MiB 3,3V
> 8-bit)
>
> I have to KEEP a Linux 2.4 and can't migrate to a Linux 2.6 for  
> this board.
>
> This type of NAND flash and JFFS2 work fine with a Linux 2.6 but  
> with a
> Linux 2.4,
> this is a little tricky :
> Linux 2.4.18 or 2.4.25 do not support this device,
> Linux 2.4.31 seems supporting this device but JFFS2 is not adapted,
> Linux 2.4.32 does not support this device anymore.
>
> On www.linux-mtd.infradead.org, it seems that Linux 2.4 is no more
> supported.
>
> Any help would be welcome
> Thanks
> Laurent
>
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
> -- 
> This message has been scanned for viruses and is believed to be clean
>

____
J.G.J. Boor                       Anton Philipsweg 1
Software Engineer                 1223 KZ Hilversum
AimSys bv                         tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   jjboor at aimsys dot nl
