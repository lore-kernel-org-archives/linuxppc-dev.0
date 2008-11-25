Return-Path: <dvomlehn@cisco.com>
Received: from rtp-iport-1.cisco.com (rtp-iport-1.cisco.com [64.102.122.148])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "rtp-iport-1.cisco.com", Issuer "Cisco SSCA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BBA74DDDE7
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 08:11:18 +1100 (EST)
Received: from rtp-core-1.cisco.com (rtp-core-1.cisco.com [64.102.124.12])
	by rtp-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id mAPKwT5B003739
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 15:58:29 -0500
Received: from sausatlsmtp1.sciatl.com (sausatlsmtp1.cisco.com
	[192.133.217.33])
	by rtp-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id mAPKwTcb021996
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 20:58:29 GMT
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
From: David VomLehn <dvomlehn@cisco.com>
To: Bill Gatliff <bgat@billgatliff.com>
In-Reply-To: <492C5DC2.9040402@billgatliff.com>
References: <20081125135519.038abf23@zod.rchland.ibm.com>
	<C5518C2F.13137%gerickson@nuovations.com>
	<b5e2fc790811251131g63ea9444x57ec0829ca0b069e@mail.gmail.com>
	<492C573E.9030309@billgatliff.com>
	<b5e2fc790811251207g38d429f3q4eb698b92162d6@mail.gmail.com>
	<492C5DC2.9040402@billgatliff.com>
Content-Type: text/plain
Date: Tue, 25 Nov 2008 12:54:50 -0800
Message-Id: <1227646490.5404.5.camel@cuplxvomd02.corp.sa.net>
Mime-Version: 1.0
Cc: Wolfgang Denx <wd@denx.de>, linux-embedded@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Grant Erickson <gerickson@nuovations.com>
Reply-To: dvomlehn@cisco.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Tue, 2008-11-25 at 14:19 -0600, Bill Gatliff wrote:

> Just trying to figure out where the walls of this "sandbox" are.  I've
> been aware of the concept of Open Firmware for a while, but haven't
> really looked into it before now--- mostly because my impression until
> now was that the available implementations were both closed-source,
> and not supporting embedded, non-PPC targets like ARM.

FWIW, at the last OLS there was interest expressed by at least one
ARM-based platform and I'm working on a set of patches to add the device
tree for MIPS. It's going very slowly and is dependent on a patchset to
add support for our platform, so it will take a while to make it
available. The important point, though, is that device tree is the only
thing approaching a standard on any non-x86-based platform for passing
structured information from the bootloader to the kernel. The command
line is just not sufficient for this.
--
David VomLehn




     - - - - -                              Cisco                            - - - - -         
This e-mail and any attachments may contain information which is confidential, 
proprietary, privileged or otherwise protected by law. The information is solely 
intended for the named addressee (or a person responsible for delivering it to 
the addressee). If you are not the intended recipient of this message, you are 
not authorized to read, print, retain, copy or disseminate this message or any 
part of it. If you have received this e-mail in error, please notify the sender 
immediately by return e-mail and delete it from your computer.
