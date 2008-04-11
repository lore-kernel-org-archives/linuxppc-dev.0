Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 15AFCDE7CE
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 01:52:08 +1000 (EST)
Received: from LPSC0173W (lpsc0173w.in2p3.fr [134.158.40.173])
	by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with SMTP id m3BFq2Ak019089
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 17:52:03 +0200
Message-ID: <016801c89beb$fbff6de0$ad289e86@LPSC0173W>
From: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
To: <linuxppc-dev@ozlabs.org>
References: <014701c89bda$09380060$ad289e86@LPSC0173W>
	<fa686aa40804110655x48120e84tde01a52d8bb39a3@mail.gmail.com>
Subject: Re: zImage.embedded
Date: Fri, 11 Apr 2008 17:51:57 +0200
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>  is the file zImage.elf my proper network image ?
>
> What bootloader is on your board?  zImage.elf *might* be the proper
> image.  If you're using u-boot, then you want to build a uImage
> instead.

I... ahem... what would you recommand for a ML405 ?
Builroot gives to options of U-Boot or Yaboot. Haven't tried either yet. 
Will do on tuesday.

I don't know if Xilinx has another solution (I remember seeing some boot 
function in the API, usable from a standalone elf file).
-- 
Guillaume Dargaud
http://www.gdargaud.net/
