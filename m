Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 51148DDECF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Dec 2007 18:49:03 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id BDF3D29EC5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Dec 2007 08:26:50 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14391-10 for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Dec 2007 08:26:40 +0100 (CET)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id AD67B29EBB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Dec 2007 08:26:39 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: MPC5121e Freescale BSP...
Date: Wed, 12 Dec 2007 08:30:30 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200712120830.30767.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi everyone,

I have an ADS5121 evaluation module from Freescale, and wonder if there's any 
Freescale engineer on this list working on the linux BSP for this 
processor/SoC/platform?

I have downloaded the latest alpha release of the BSP and found it to be 
completely unusable. I took some time to fix the framebuffer driver, and make 
console-fb work, I even sent patches to our Freescale contact, while I 
already suspected it to be completely useless, since the BSP is already 
lacking behind several months from actual Freescale code, and all those 
issues are most probably fixed already. Only problem: I can't seem to get the 
latest versions of it. I heared rumors they'll release a new version next 
week or so, but I fear it will also lack behind development, and fixing bugs 
myself or contributing code will be a useless waste of time!

Is there any Freescale engineer on this list that can help out, or at least 
clarify the reasons behind closed-doors open-source software development??

On the other hand, I also whish to contact other furtunate owners of 
PPC5121e-based hardware to join forces on linux-kernel driver development. If 
Freescale won't collaborate, I'd even consider forking their code, if 
necessary.

Greetings,

-- 
David Jander
Protonic Holland.
