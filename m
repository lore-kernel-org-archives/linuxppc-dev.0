Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s8.bay0.hotmail.com (bay0-omc3-s8.bay0.hotmail.com
	[65.54.246.208]) by ozlabs.org (Postfix) with ESMTP id 37CADDE3B5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 23:54:52 +1000 (EST)
Message-ID: <BAY138-F321041302226B3292DBB26B2D20@phx.gbl>
In-Reply-To: <46D2C9A5.9030708@fz-juelich.de>
From: "Ming Liu" <eemingliu@hotmail.com>
To: g.schardt@fz-juelich.de, linuxppc-embedded@ozlabs.org
Subject: RE: Newbie and linux on virtex-II ppc
Date: Mon, 27 Aug 2007 13:54:46 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Georg,

>is it possible to run a kernel that way ? or need i some kind of
>bootloader ?
>or is this complete the wrong way ?

Yes, you can. Actually what I did is to include a bootloop in the hardware 
bitstream and that will keep your CPU waiting until the kernel's running.

BR
Ming

_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger:  http://messenger.msn.com/cn  
