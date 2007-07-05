Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 9784EDDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jul 2007 23:58:39 +1000 (EST)
Message-ID: <468CF906.4000202@anagramm.de>
Date: Thu, 05 Jul 2007 15:58:30 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Ansari <ma.harounansari@gdatech.co.in>
Subject: Re: MPC8540 DMA transfer
References: <000501c7be46$368236c0$9503a8c0@Ansari>
In-Reply-To: <000501c7be46$368236c0$9503a8c0@Ansari>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hello, Ansari!

Ansari schrieb:
> Hello Koller,
>  
> Is there any support for dma transter in linux 2.4.x kernel . Whether u 
> have any source code for tht ?????. I think u have attached a dma driver 
> code for 2.6.x kernel . But i need it for 2.4 kernel. ( Processor : 
> MPC8540 / MPC8560 )

There are no new features going into kernel 2.4.x. Development has stopped
long time ago. Have a look at the available code and backport it to 2.4 (YMMV).
But you propably want to move to the latest 2.6. The MPC8540 is supported
very well.
If you want to have new features implemented, use the latest 2.6.x tree from
Linus. Don't ride dead horses!

Regards,
-- 
Clemens Koller
__________________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Straße 45/1
Linhof Werksgelände
D-81379 München
Tel.089-741518-50
Fax 089-741518-19
http://www.anagramm-technology.com
