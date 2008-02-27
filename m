Return-Path: <stefanr@s5r6.in-berlin.de>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.vr.in-berlin.de",
	Issuer "IN-Berlin Server CA (G2)" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 7E007DDE0D
	for <linuxppc-dev@ozlabs.org>; Thu, 28 Feb 2008 07:08:51 +1100 (EST)
Message-ID: <47C5C340.7080302@s5r6.in-berlin.de>
Date: Wed, 27 Feb 2008 21:08:32 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
MIME-Version: 1.0
To: Jarod Wilson <jwilson@redhat.com>
Subject: Re: [PATCH 1/2] firewire: endianess fix
References: <20080220220326.GA22328@uranus.ravnborg.org>
	<tkrat.e2bfb30f2c0ae70a@s5r6.in-berlin.de>
	<tkrat.9e19fa31951506af@s5r6.in-berlin.de>
	<200802271458.28401.jwilson@redhat.com>
In-Reply-To: <200802271458.28401.jwilson@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Kristian Hoegsberg <krh@bitplanet.net>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, sparclinux@vger.kernel.org,
	linux1394-devel@lists.sourceforge.net, Sam Ravnborg <sam@ravnborg.org>,
	Harvey Harrison <harvey.harrison@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jarod Wilson wrote:
> Works just fine with the Apple UniNorth controller in my powerbook in cursory 
> testing.

Could you remove the OHCI1394_HCControl_postedWriteEnable flag from 
fw-ohci.c::ohci_enable() and test without and with the endianess patch?
-- 
Stefan Richter
-=====-==--- --=- ==-==
http://arcgraph.de/sr/
