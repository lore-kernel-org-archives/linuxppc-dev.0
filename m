Return-Path: <linuxppcemb@lkmail.de>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.s-s-l.net",
	Issuer "Equifax Secure Global eBusiness CA-1" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45B92DDF09
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Feb 2007 02:37:52 +1100 (EST)
Message-ID: <45E2FEB8.1060007@lkmail.de>
Date: Mon, 26 Feb 2007 16:37:28 +0100
From: Lorenz Kolb <linuxppcemb@lkmail.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: I can I boot u-boot from flash on Virtex-4 based board
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 26 Feb 2007 09:55:55 +0800
"yunfeizhang" <yunfeizhang ( a t ) sjtu.edu.cn> wrote:
> 
> Hi all,
> I am confused for a long time about on how to boot a common program on Virtex. I want to porting a 
> 
> u-boot to Xilinx VIrtex-4 ML403 Evaluation Board, but I can even boot a common program from flash.
> 
> can someone give me some advice, thanks for all your kindness!

Hi,

I already found that non trivial.

Easiest way is: write some mini-bootloader that fits into BRAM and loads u-boot from flash.

If you need some more detailed instructions and a patch created from Xilinx'u-boot tree to patch u-boot 1.20 to work with ML403 I can send you the files.

Greetings,

Lorenz Kolb
