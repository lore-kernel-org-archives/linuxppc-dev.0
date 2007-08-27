Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 4D2E8DDF00
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Aug 2007 05:14:21 +1000 (EST)
To: "Mustafa Cayir" <mustafa.cayir@bte.mam.gov.tr>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: STK5200 pci_enable_device problem
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 27 Aug 2007 14:08:12 +0300."
	<7B9A8FF57DBB524190E98CABF6E56F070B927E@itri.bte.mam.gov.tr>
Date: Mon, 27 Aug 2007 21:14:19 +0200
Sender: wd@denx.de
Message-Id: <20070827191419.9A9CE24044@gemini.denx.de>
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

In message <7B9A8FF57DBB524190E98CABF6E56F070B927E@itri.bte.mam.gov.tr> you wrote:
> 
> i use 2.4.25 kernel and eldk 3.1.1 on TQM5200 board. i tried denx 2.6.19
> kernel to port on TQM5200 but i couldn't.
> Did you port 2.6 kernel on TQM5200? Did pci device start working
> succesfully after porting 2.6 kernel to TQM5200 board.

Current top-of-tree in our git repo has been tested with a Intel
EEPRO100 network card in the ST5200's PCI slot. It's working.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Unsichtbar macht sich die Dummheit, indem sie immer  größere  Ausmaße
annimmt.                             -- Bertold Brecht: Der Tui-Roman
