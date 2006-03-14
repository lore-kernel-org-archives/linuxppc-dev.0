Return-Path: <edjubenville@adelphia.net>
Received: from mta11.adelphia.net (mta11.adelphia.net [68.168.78.205])
	by ozlabs.org (Postfix) with ESMTP id 2513D67A0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Mar 2006 06:29:09 +1100 (EST)
Received: from EJ1 ([70.37.70.76]) by mta11.adelphia.net
	(InterMail vM.6.01.05.02 201-2131-123-102-20050715) with SMTP
	id <20060314192907.DWBP28141.mta11.adelphia.net@EJ1>
	for <linuxppc-embedded@ozlabs.org>; Tue, 14 Mar 2006 14:29:07 -0500
From: "Edward Jubenville" <edjubenville@adelphia.net>
To: <linuxppc-embedded@ozlabs.org>
Subject: RE: Where to define IO ports 
Date: Tue, 14 Mar 2006 11:29:06 -0800
Message-ID: <GPECLCIGPLHEOMGPMCPAKEMADIAA.edjubenville@adelphia.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <20060314181638.3586D3539FF@atlas.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk had replied:

>> I think you should change the "u-boot".
>
>NO. Linux stuff should be done in Linux.
>
>>  - include/configs/IceCube.h
>>  - board/icecube/icecube.h
>> 
>> 1st, put a constant like (CFG_CS1_START, CFG_CS1_STOP, CFG_CS1_CFG) to
>> IceCube.h.
>
>NO again. If you port to your own board, you should create  your  own
>board  configuration  instead  of  messing  with  an existing one for
>another board.

Is there a HOWTO on the subject of "creating my own board configuration"?

Do I put hooks in "make menuconfig" to enable/disable my customizations? 

I'm new to the process of building kernels, and I have been using an
off-the-shelf development board that had a supported configuration, so
my only customizations have been turning on/off preconfigured options. 
Any guidance, or the name of a more appropriate list in which to
post the question would be appreciated.

Thanks,

Ed
