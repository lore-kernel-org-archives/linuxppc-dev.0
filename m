Return-Path: <Vikas.Aggarwal@oft.state.ny.us>
Received: from mailc.nysemail.state.ny.us (mail.nysemail.state.ny.us
	[198.22.236.200]) by ozlabs.org (Postfix) with ESMTP id 1AB2A679E6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 04:24:00 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Thu, 2 Jun 2005 14:11:55 -0400
Message-ID: <0BAE938A1E68534E928747B9B46A759A8F3CC0@EXCNYSM0A1AH.nysemail.nyenet>
From: "Aggarwal, Vikas \(OFT\)" <Vikas.Aggarwal@oft.state.ny.us>
To: <linuxppc-embedded@ozlabs.org>
Subject: newbie question: module-init-tools  for  PPC  embedded linux
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

Trying to ./insmod a hello_world.ko  module  on my  EP8248 card  from
embeddedplanet.com. The board already supports and comes with 2.6
kernel.
I get a  message "./insmod QM_MODULES: function not implemented"

I cross compiled my kernel with MODULE support in "make xconfig"

After little googling found that i need Rusty Russell's
module-init-tools.
Can anyone guide me how to configure & make & install  these
module-init-tools  for my  cross compilation.

-vikas aggarwal
--------------------------------------------------------
This e-mail, including any attachments, may be confidential, privileged =
or otherwise legally protected. It is intended only for the addressee. =
If you received this e-mail in error or from someone who was not =
authorized to send it to you, do not disseminate, copy or otherwise use =
this e-mail or its attachments.  Please notify the sender immediately by =
reply e-mail and delete the e-mail from your system.
