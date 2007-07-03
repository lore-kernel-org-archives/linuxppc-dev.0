Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BD262DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 11:37:34 +1000 (EST)
Subject: Re: help on dts compiler please.
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: "Bizhan Gholikhamseh (bgholikh)" <bgholikh@cisco.com>
In-Reply-To: <F795765B112E7344AF36AA911279641502D1A454@xmb-sjc-212.amer.cisco.com>
References: <F795765B112E7344AF36AA911279641502D1A454@xmb-sjc-212.amer.cisco.com>
Content-Type: text/plain
Date: Mon, 02 Jul 2007 20:33:24 -0500
Message-Id: <1183426404.5643.0.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
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

On Mon, 2007-07-02 at 17:04 -0700, Bizhan Gholikhamseh (bgholikh) wrote:
> Hi 
> I have downloaded the latest Linux code from the following git tree:
> git:// git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git
>  
> I have also installed dtc compiler version.
> I am trying to create dtb file from mpc8541cds.dts.
> I ran the following command and get error:
>  
> $ dtc -f -I dts -O dtb mpc8541cds.dts
> DTC: dts->dtb  on file "mpc8541cds.dts"
> syntax error at line 15
> FATAL ERROR: Couldn't read input tree

Where did you get your dtc version from?

josh
