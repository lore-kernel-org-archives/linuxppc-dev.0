Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 71D0CDDE1A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Aug 2007 09:31:08 +1000 (EST)
To: Oliver Rutsch <orutsch@sympatec.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: STK5200 pci_enable_device problem
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 29 Aug 2007 14:52:53 +0200."
	<46D56C25.3020702@sympatec.com>
Date: Thu, 30 Aug 2007 01:31:06 +0200
Sender: wd@denx.de
Message-Id: <20070829233106.9766C24044@gemini.denx.de>
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

In message <46D56C25.3020702@sympatec.com> you wrote:
> 
> > Also, you need a recent version of U-Boot (for  example  99c2fdab  or
> > later).
> 
> I'm using U-Boot 1.2.0-gbc2b9c33-dirty (Feb 22 2007 - 09:53:14). Is that 
> recent enough? (I don't know exactly what you mean with "99c2fdab", is 
> this the second number after "1.2.0-"?)

No, that is *way* too old.

The number after the "-g" is the (initial 8 digits of the) git commit
ID. You can use this to identify  a  spoecific  version  in  the  git
repository.

> Maybe the problem is the missing tqm5200.dtb file. I have booted the 
> kernel without it (just bootm 200000). Does the kernel need this file? I 

Yes. An arch/powerpc kernel will not run without a proper device tree.

> found a tqm5200.dts file the the kernel sources, but the device tree 
> compiler (dtc) seems not to be in the 4.1 ELDK. Do I have to install 
> this compiler and build the appropriate dtb file?

Yes, this is correct. dtc will be included with ELDK 4.2.

> In older kernels it was O.K. just to uncheck the SM501 drivers in the 
> kernel configuration. Has this changed?

As mentioned above, with arch/powerpc you always need a  device  tree
blob.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I express preference for a chronological  sequence  of  events  which
precludes a violence.   - Terry Pratchett, _The Dark Side of the Sun_
