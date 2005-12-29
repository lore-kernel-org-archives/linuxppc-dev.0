Return-Path: <sheutlin@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id 685136896A
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Dec 2005 03:23:12 +1100 (EST)
Message-ID: <43B40BFF.1040809@gmx.de>
Date: Thu, 29 Dec 2005 17:17:03 +0100
From: Sebastian Heutling <sheutlin@gmx.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: PowerstackII Utah - PCI IRQ for IDE
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I wonder what happened to the PCI IRQ map for the PowerstackII Utah - 
specifically the IDE IRQ. On http://patchwork.ozlabs.org/linuxppc/ I see 
a patch from Sven Luther with a set IDE IRQ line 
(http://patchwork.ozlabs.org/linuxppc//patch?id=1082) but on current 
kernels it doesn't appear. Even on debian the only kernel that had a 
working kernel with IDE for this machine was 2.6.8 but any following 
kernel (up to the current 2.6.14) doesn't include any patch for IDE IRQ.


Sebastian
