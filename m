Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B5102DDEF3
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 15:19:53 +1000 (EST)
Message-ID: <4876ED6F.2030107@pobox.com>
Date: Fri, 11 Jul 2008 01:19:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH v2] ibm_newemac: Add MII mode support to the EMAC RGMII
	bridge.
References: <C497F939.104DB%gerickson@nuovations.com>
	<1215529386-12749-1-git-send-email-gerickson@nuovations.com>
	<1215573802.8970.302.camel@pasglop>
In-Reply-To: <1215573802.8970.302.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, sr@denx.de,
	Grant Erickson <gerickson@nuovations.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Tue, 2008-07-08 at 08:03 -0700, Grant Erickson wrote:
>> This patch adds support to the RGMII handler in the EMAC driver for
>> the MII PHY mode such that device tree entries of the form `phy-mode = "mii";'
>> are recognized and handled appropriately.
>>
>> While logically, in software, "gmii" and "mii" modes are the same,
>> they are wired differently, so it makes sense to allow DTS authors to
>> specify each explicitly.
>>
>> Signed-off-by: Grant Erickson <gerickson@nuovations.com>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

ACK


> Jeff, I'd like to apply that (and other EMAC patches for 2.6.27, do you
> have anything else pending ?) via my tree provided you give me your ack.
> The reason is that the multicast fix one is going that way as it touches
> other arch files, and subsequent ones are now likely to conflict.
> 
> Let me know if that's ok with you in which case I'll stick your ack in
> there.

Ok w/ me!
