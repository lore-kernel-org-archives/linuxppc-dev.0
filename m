Return-Path: <hans.lehmann@ritter-elektronik.de>
Received: from mail5.oerlikon.com (mail5.oerlikon.com [193.158.88.212])
	by ozlabs.org (Postfix) with ESMTP id 0E7E8DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2008 01:19:29 +1100 (EST)
Received: from anetcsgv210.dom03.net (localhost.localdomain [127.0.0.1])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id DB9C92E97B1
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 15:04:20 +0100 (CET)
Received: from anetcsgv202.dom03.net (anetcsgv202.dom03.net [193.158.88.254])
	by anetcsgv210.dom03.net (Postfix) with ESMTP id D4F6A2E97BC
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 15:04:20 +0100 (CET)
Received: from SRVWWP01.sts.saurer.vpn (unknown [10.33.20.167])
	by anetcsgv202.dom03.net (postfix-1) with ESMTP id D2D2214EBD
	for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2008 15:04:20 +0100 (CET)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: [PATCH]: [MPC5200] Add ATA DMA support
Date: Tue, 11 Nov 2008 15:04:20 +0100
Message-ID: <633A55242A59C7488FAAF5A6850929984B8133@SRVEXC01.sts.saurer.vpn>
In-Reply-To: <792f5f410808130207t6ef3c3ddxeff0ad0debb39242@mail.gmail.com>
References: <20080813061135.GH17587@secretlab.ca>
	<792f5f410808130207t6ef3c3ddxeff0ad0debb39242@mail.gmail.com>
From: "Lehmann, Hans (Ritter Elektronik)" <hans.lehmann@ritter-elektronik.de>
To: "Tim Yamin" <plasm@roo.me.uk>, "Grant Likely" <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tim, Grant,

I have tested the patch on our MPC5200B based board with Kingston Elite =
Pro CF-card and it worked fine with DMA2. I have port the patch back to =
2.6.24.7 Kernel and I can't detect problems our errors, even with big =
files (40 mB) over FEC wich I save to card . We get performance up to =
10,5mB/s which is near to the max. speed.

Greetings




Mit freundlichen Gr=FC=DFen

Hans Lehmann
Softwareentwicklung

Telefon	+49 (0)2191-67-2520
Fax 	+49 (0)2191-67-703408
e-mail 	hans.lehmann@ritter-elektronik.de



Ritter Elektronik GmbH
Leverkuser Stra=DFe 65
D-42897 Remscheid
www.ritter-elektronik.de

Gesch=E4ftsf=FChrer: Manfred A. Wagner, Dr. Uwe Baader
Sitz der Gesellschaft: Oberhausen
HRB 17168 Duisburg  /  USt-ID DE 814009849


-----Urspr=FCngliche Nachricht-----
Von: linuxppc-dev-bounces+hans.lehmann=3Dritter-elektronik.de@ozlabs.org =
[mailto:linuxppc-dev-bounces+hans.lehmann=3Dritter-elektronik.de@ozlabs.o=
rg] Im Auftrag von Tim Yamin
Gesendet: Mittwoch, 13. August 2008 11:07
An: Grant Likely
Cc: linuxppc-dev@ozlabs.org
Betreff: [WW Spam: medium] Re: [PATCH]: [MPC5200] Add ATA DMA support

On Wed, Aug 13, 2008 at 7:11 AM, Grant Likely =
<grant.likely@secretlab.ca> wrote:
> Sounds good to me.  You will get more testers that way.  I can pick it =

> up for -next if everything else looks good.

Here are the new patches; tested against 2.6.27-rc3.

Thanks,

Tim
