Return-Path: <dibacco@inwind.it>
Received: from smtp5.libero.it (smtp5.libero.it [193.70.192.55])
	by ozlabs.org (Postfix) with ESMTP id AD03B679E9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 13 Feb 2006 07:17:49 +1100 (EST)
Received: from localhost (172.16.1.84) by smtp5.libero.it (7.0.027-DD01)
	id 43E222B600E16862 for linuxppc-embedded@ozlabs.org;
	Sun, 12 Feb 2006 21:17:47 +0100
Received: from smtp1.libero.it ([172.16.1.224])
	by localhost (asav5.libero.it [193.70.192.154]) (amavisd-new,
	port 10024)
	with ESMTP id 10671-01-4 for <linuxppc-embedded@ozlabs.org>;
	Sun, 12 Feb 2006 21:17:46 +0100 (CET)
Date: Sun, 12 Feb 2006 21:17:46 +0100
Message-Id: <IULCDM$BABECCECA1AD7F3553D47D5BCC878B75@libero.it>
Subject: Re:MBX AMD AM29F080 flash not recognized
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "dibacco\@inwind\.it" <dibacco@inwind.it>
To: "dibacco" <dibacco@inwind.it>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sorry, the problem was that I didn't configure the Interleave 4, and the =
MBX use 4 chips of AM29F080.



---------- Initial Header -----------

>From      : linuxppc-embedded-bounces@ozlabs.org
To          : "linuxppc-embedded" linuxppc-embedded@ozlabs.org
Cc          : 
Date      : Sat, 11 Feb 2006 17:51:08 +0100
Subject : MBX AMD AM29F080 flash not recognized







> Hi,
> 
> on my MBX board I have two flashes: AM29F040 called bootrom and four ch=
ips of AM29F080 (each one 8 Mbit for a total of 4MB).
> 
> The kernel (from DENX) doesn't find the AM29F080. I added the following=
 in amd_flash.c to support AM29F040 (a friend of mine told me)
> 
> #define AM29F040	0x00A4
> 
> and also:
> 
> {
>                 mfr_id: MANUFACTURER_AMD,
> 		dev_id: AM29F040,
> 		name: "AMD AMD29F040",
> 		size: 0x00080000,
> 		numeraseregions: 1,
> 		regions: {
> 	          { offset: 0x000000, erasesize: 0x10000, numblocks: 8 },
> 		}
> },
> 
> in the amd_flash_info table.
> 
> For AM29F080 I don't know what to add and if to add something is ok !?!=
?!?!?
> 
> Someone knows?
> 
> Furthermore, how can I specify that there are 4 chips of AM29F080?
> 
> The kernel will handle this automatically?
> 
> Bye,
> Antonio.
> 
> 
> 
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
