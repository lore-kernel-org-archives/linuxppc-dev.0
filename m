Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 6A85BDDE43
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 07:08:30 +1000 (EST)
To: =?iso-8859-9?Q?Mustafa_Cay=FDr?= <mustafa.cayir@bte.mam.gov.tr>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: STK5200 pci_enable_device problem
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 23 Aug 2007 08:42:28 +0300."
	<7B9A8FF57DBB524190E98CABF6E56F078FAE4E@itri.bte.mam.gov.tr>
Date: Sun, 26 Aug 2007 23:08:27 +0200
Sender: wd@denx.de
Message-Id: <20070826210827.5E68C24047@gemini.denx.de>
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

In message <7B9A8FF57DBB524190E98CABF6E56F078FAE4E@itri.bte.mam.gov.tr> you wrote:
> 
> I am working on TQ STK52000 development board with TQM5200-AB cpu module. I am trying to use PCI bus and Local Plus Bus together. SM501, video chip is located on local plus bus and PLX9030 based pci device is on pci bus.
> 
> My pci driver is able to scan pci bus and find succesfully the pci device. After this point, pci_enable_device function returns following error:
> 
> PCI:  Device 00:18.0 not available because of resource collisions

Did you try the linux-2.6-denx repo on our server? Note  that  you'll
need a somewhat recent version of U-Boot for device tree support.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
PLEASE NOTE: Some Quantum Physics Theories Suggest That When the Con-
sumer Is Not Directly Observing This Product, It May Cease  to  Exist
or Will Exist Only in a Vague and Undetermined State.
