Return-Path: <DaveLiu@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 1C75B67A40
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 15:21:59 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k5L6cdFq025953 for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 00:38:39 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k5L5LsuY003045
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 00:21:56 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD4673026FD951@zch01exm40.ap.freescale.net>
From: Liu Dave-r63238 <DaveLiu@freescale.com>
To: "'Prabhat_Singh'" <Prabhat_Singh@Satyam.com>, linuxppc-embedded@ozlabs.org
Subject: RE: Exceptions during PCI initialization at u-boot
Date: Wed, 21 Jun 2006 13:21:54 +0800
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Can you give me the more information of context? For example,
What is the PCI initialize code you used? What is the PCI bus write operation?

-Dave

> -----Original Message-----
> From: Prabhat_Singh [mailto:Prabhat_Singh@Satyam.com] 
> Sent: Tuesday, June 20, 2006 8:19 PM
> To: Liu Dave-r63238; linuxppc-embedded@ozlabs.org
> Subject: RE: Exceptions during PCI initialization at u-boot
> 
> 
> Hi Dave,
> Thanks for prompt response, it's really helped. 
> 
> By reading ESR (error status register) I found that machine 
> check exception is coming because of "PCI parity error 
> received on a write" bit 7 of ESR is getting set.
> 
> Can you tell me reason and the possible solution for this one.
> 
> Regards
> Prabhat
> 
