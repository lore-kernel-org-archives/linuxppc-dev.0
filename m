Return-Path: <Orges.Furxhi@thyssenkrupp.com>
Received: from mail002.triaton.com (mail002.triaton.com [149.250.222.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "mail002.triaton.com",
	Issuer "TC TrustCenter for Security in Data Networks GmbH" (not
	verified)) by ozlabs.org (Postfix) with ESMTP id EFB1D67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jul 2006 07:09:52 +1000 (EST)
Received: from frasintmail2.it09.biz (frasintmail2.triaton.com [195.203.86.9])
	by mail002.triaton.com (8.13.7/8.13.7) with ESMTP id k6SL9j1T030563
	for <linuxppc-embedded@ozlabs.org>; Fri, 28 Jul 2006 23:09:45 +0200
Received: from localhost (localhost [127.0.0.1])
	by frasintmail2.it09.biz (Postfix) with ESMTP id D914E1C1C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jul 2006 23:08:40 +0200 (CEST)
Received: from mdcexc05.na.ops.local (tkeweb07.thyssenkruppelevator.com
	[66.194.145.38])
	by frasintmail2.it09.biz (Postfix) with ESMTP id 41A331C1A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jul 2006 23:08:40 +0200 (CEST)
Message-ID: <162B449665D6D643AD9E1D50FC6F4B14042F1C98@mdcexc05.na.ops.local>
From: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: RE: USB flashdrive on Motorola MPC5200 (IceCube) board, linux ker
	nel 2.4.25 (DENX drop)
Date: Fri, 28 Jul 2006 16:09:38 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_000_01C6B28A.22EE4770"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_000_01C6B28A.22EE4770
Content-Type: text/plain



-----Original Message-----
From: Furxhi, Orges 
Sent: Friday, July 28, 2006 4:03 PM
To: 'Wolfgang Denk'
Subject: RE: USB flashdrive on Motorola MPC5200 (IceCube) board, linux
kernel 2.4.25 (DENX drop) 



-----Original Message-----
From: Wolfgang Denk [mailto:wd@denx.de] 
Sent: Friday, July 28, 2006 3:08 PM
To: Furxhi, Orges
Cc: 'Igor Luri'; linuxppc-embedded@ozlabs.org
Subject: Re: USB flashdrive on Motorola MPC5200 (IceCube) board, linux
kernel 2.4.25 (DENX drop) 

Dear Orges,

in message <162B449665D6D643AD9E1D50FC6F4B14042F1C93@mdcexc05.na.ops.local>
you wrote:
> 
> I have a LITE5200 Version 2.0 board and I have loaded the latest DENX drop
> of the 2.4 kernel on it. When I plug in the usb flash drive I get the
> following message:
> 
> Usb.c: USB device not accepting new address=4 (error=-110)   
> Usb.c: USB device not accepting new address=5 (error=-110)
> 
> I must be doing something wrong, and I do not know what it is.

Are you just trying one specific type opf USB device,  or  does  this
happen with several 5 or more) different devices?

We tried 6 different USB flash drives:
	GE intelligent stick 2.0 (256MB)
	PNY
	SanDisk Cruzer Micro (256MB)
	Version G (512MB)
	Memorex traveldrive mini (512MB)
	Unknown brand (64MB) 

Are there any flashdrives that are known to always work?		


> You said that you had the same board and kernel and that your USB as mass
> storage was working. Could you please send me your kernel's .config file
so
> that I can compare it with mine? 

You can just use the  default  configuration  as  provided  with  the
kernel  tree.  Make  sure to use a current kernel (top of tree in git
repo).

We have the latest 2.4 drop from the git repo. Which of the defconfig files
should we use? None of them had usb storage enabled (icecube board).
 

Thanks a lot,

Orges

And keep in mind  that  many  USB  devices  are  simply  not  strctly
standard conforming. Some will work, others won't.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The biggest difference between time and space is that you can't reuse
time.                                                 - Merrick Furst

------_=_NextPart_000_01C6B28A.22EE4770
Content-Type: application/ms-tnef
Content-Transfer-Encoding: base64

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
AIAQ/////wMAkhABAAAAAgFHAAEAAAA1AAAAYz1VUzthPSA7cD1kb3ZlcmludGw7bD1NRENFWEMw
NS0wNjA3MjgyMTA5MzhaLTEwNzgzMAAAAAACAfk/AQAAAGAAAAAAAAAA3KdAyMBCEBq0uQgAKy/h
ggEAAAAAAAAAL089RE9WRVIgRUxFVkFUT1JTL09VPURPVkVSX0hPUk5fTEFLRS9DTj1SRUNJUElF
TlRTL0NOPU9SR0VTLkZVUlhISQAeAPg/AQAAAA4AAABGdXJ4aGksIE9yZ2VzAAAAHgA4QAEAAAAN
AAAAT1JHRVMuRlVSWEhJAAAAAAIB+z8BAAAAYAAAAAAAAADcp0DIwEIQGrS5CAArL+GCAQAAAAAA
AAAvTz1ET1ZFUiBFTEVWQVRPUlMvT1U9RE9WRVJfSE9STl9MQUtFL0NOPVJFQ0lQSUVOVFMvQ049
T1JHRVMuRlVSWEhJAB4A+j8BAAAADgAAAEZ1cnhoaSwgT3JnZXMAAAAeADlAAQAAAA0AAABPUkdF
Uy5GVVJYSEkAAAAAQAAHMG7nRhiKssYBQAAIMCL1yieKssYBHgA9AAEAAAAFAAAAUkU6IAAAAAAe
AB0OAQAAAFUAAABVU0IgZmxhc2hkcml2ZSBvbiBNb3Rvcm9sYSBNUEM1MjAwIChJY2VDdWJlKSBi
b2FyZCwgbGludXgga2VybmVsIDIuNC4yNSAoREVOWCBkcm9wKSAAAAAAHgA1EAEAAABBAAAAPDE2
MkI0NDk2NjVENkQ2NDNBRDlFMUQ1MEZDNkY0QjE0MDQyRjFDOThAbWRjZXhjMDUubmEub3BzLmxv
Y2FsPgAAAAALACkAAAAAAAsAIwAAAAAAAwAGEAad0yYDAAcQzwYAAAMAEBAAAAAAAwAREAAAAAAe
AAgQAQAAAGUAAAAtLS0tLU9SSUdJTkFMTUVTU0FHRS0tLS0tRlJPTTpGVVJYSEksT1JHRVNTRU5U
OkZSSURBWSxKVUxZMjgsMjAwNjQ6MDNQTVRPOldPTEZHQU5HREVOS1NVQkpFQ1Q6UkU6VVNCAAAA
AAIBfwABAAAAQQAAADwxNjJCNDQ5NjY1RDZENjQzQUQ5RTFENTBGQzZGNEIxNDA0MkYxQzk4QG1k
Y2V4YzA1Lm5hLm9wcy5sb2NhbD4AAAAAAq8=

------_=_NextPart_000_01C6B28A.22EE4770--
