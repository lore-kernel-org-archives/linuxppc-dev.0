Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 81B9BDDDCA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 07:10:23 +1000 (EST)
To: Oliver Rutsch <orutsch@sympatec.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: STK5200 pci_enable_device problem
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 23 Aug 2007 09:24:08 +0200."
	<46CD3618.70801@sympatec.com>
Date: Sun, 26 Aug 2007 23:10:21 +0200
Sender: wd@denx.de
Message-Id: <20070826211021.BD3E724047@gemini.denx.de>
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

In message <46CD3618.70801@sympatec.com> you wrote:
>
> Which ELDK and kernel do you use? I had the same problem on this board 
> with a PLX9054 based PCI card on a 2.4.25 kernel. I switched to the 2.6 
> kernel and the 4.1 ELDK and the card was scanned correctly.
> But keep in mind that the linux PLX drivers do not work out of the box 
> with a big endian platform like the MPC5200. Although there is a 
> BIG_ENDIAN flag in the makefiles there are still some places left in the 
> driver code which have to be patched (the parts with int64 adresses).
> It's not so easy to compile the PLX drivers on the 4.1 ELDK because of 
> missing headers in the ppc architecture. I managed to build the drivers 
> for the 2.6.19 kernel and I was able to work with the card except the 
> DMA routines (still working on this issue).

WHy don't you use the arch/powerpc configuration, then? Note that the
STK5200 has never been supported in a  2.6  kernel  with  a  arch/ppc
configuration.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"When the only  tool  you  have  is  a  hammer,  you  tend  to  treat
everything as if it were a nail."                    - Abraham Maslow
