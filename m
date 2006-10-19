Return-Path: <nd@bplan-gmbh.de>
Received: from natblert.rzone.de (natblert.rzone.de [81.169.145.181])
	by ozlabs.org (Postfix) with ESMTP id 6F4EB67B61
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Oct 2006 23:36:15 +1000 (EST)
Message-ID: <45377ED3.9030001@bplan-gmbh.de>
Date: Thu, 19 Oct 2006 15:34:11 +0200
From: Nicolas DET <nd@bplan-gmbh.de>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: Badness in irq_create_mapping at arch/powerpc/kernel/irq.c:527
References: <20061019122802.GA26637@aepfle.de>
In-Reply-To: <20061019122802.GA26637@aepfle.de>
Content-Type: multipart/mixed; boundary="------------070801050702090409050507"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------070801050702090409050507
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Olaf Hering wrote:
 > I get irq warnings with current Linus tree on Pegasos.
 > The EDID handling for radeonfb appears to be broken as well,
 > but thats a different story:
 >

This patch enables chrp_pcibios_fixup() for bPlan's machine. however, 
this function should NOT be called as thoses platforms.

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=26c5032eaa64090b2a01973b0c6ea9e7f6a80fa7

An upcomming patch will "ppc_md.pcibios_fixup = NULL;" for every bPlan's 
platforms.

Regards,

--------------070801050702090409050507
Content-Type: text/x-vcard; charset=utf-8;
 name="nd.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="nd.vcf"

begin:vcard
fn:Nicolas DET ( bplan GmbH )
n:DET;Nicolas
org:bplan GmbH
adr:;;;;;;Germany
email;internet:nd@bplan-gmbh.de
title:Software Entwicklung
tel;work:+49 6171 9187 - 31
x-mozilla-html:FALSE
url:http://www.bplan-gmbh.de
version:2.1
end:vcard


--------------070801050702090409050507--
