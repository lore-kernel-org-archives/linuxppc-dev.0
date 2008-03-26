Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D01D6DE98C
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 23:44:26 +1100 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m2QBlu9E005152
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Mar 2008 12:47:56 +0100
Message-ID: <052801c88f37$3b51f7e0$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
Subject: Re: Patch: FW:Xilinx: BSP: Updated ML405 to match hardware used for
	testing
Date: Wed, 26 Mar 2008 12:47:46 +0100
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello all,

I'm trying to get things up and running on a Xilinx Virtex-4 ml405 board, 
and as such I've been trying to figure out the following recent message to 
the list:
http://patchwork.ozlabs.org/linuxppc/patch?person=1226&id=17037

I don't understand what this patch applies to: it references files such as 
ml405_defconfig which are not part of the normal kernel tree and which I 
cannot find anywhere. Is there some other kind of patch that needs to apply 
first in order to get for instance CONFIG_XILINX_DRIVERS, 
CONFIG_XILINX_EMAC, etc...

Thanks
-- 
Guillaume Dargaud
http://www.gdargaud.net/
