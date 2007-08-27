Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 7D066DDE9B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 04:58:56 +1000 (EST)
To: Oliver Rutsch <orutsch@sympatec.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: STK5200 pci_enable_device problem
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 27 Aug 2007 08:25:03 +0200."
	<46D26E3F.8040309@sympatec.com>
Date: Mon, 27 Aug 2007 20:58:53 +0200
Sender: wd@denx.de
Message-Id: <20070827185853.76E3A24047@gemini.denx.de>
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

In message <46D26E3F.8040309@sympatec.com> you wrote:
> 
>  >> It's not so easy to compile the PLX drivers on the 4.1 ELDK because of
>  >> missing headers in the ppc architecture. I managed to build the drivers
>  >> for the 2.6.19 kernel and I was able to work with the card except the
>  >> DMA routines (still working on this issue).
>  >
>  > WHy don't you use the arch/powerpc configuration, then? Note that the
>  > STK5200 has never been supported in a  2.6  kernel  with  a  arch/ppc
>  > configuration.
>  >
> 
> Because I found at least a lite5200 configuration in the 4.1 ELDK 
> (2.6.19.2 kernel) in the ARCH/ppc architecure. With ARCH/powerpc I only 

You will find many completely unsupported board configurations in the
kernel.org tree, too. The fact that somethign  is  present  does  not
mean anything.

> Is there support for the TQM5200 and the STK5200 with ARCH/powerpc in 
> newer kernels? I'm still using the 3.1.1 ELDK for the TQM5200 as it have 
> everything I need and I don't need to use the PLX card in this board 
> (although it would have been nice if I got it working...).

The TQM5200 / STK5200 are supported in our linux-2.6-denx  tree  with
an  arch/powerpc  configuration; also lite5200b. Note that - like all
MPC5200 support in the 2.6 kernel - this is all work in progress.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
It is dangerous to be right on a subject  on  which  the  established
authorities are wrong.                                    -- Voltaire
