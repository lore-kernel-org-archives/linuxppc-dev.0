Return-Path: <bryano@europlex.ie>
Received: from europlex.ie (unknown [193.120.144.98])
	by ozlabs.org (Postfix) with ESMTP id 94B7A67A73
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 04:33:40 +1100 (EST)
Message-ID: <41ED478A.6020303@europlex.ie>
Date: Tue, 18 Jan 2005 17:29:46 +0000
From: Bryan O'Donoghue <bryano@europlex.ie>
MIME-Version: 1.0
To: "Dayton, Dean" <deand@aiinet.com>
References: <C0170D0AF1277849A4B4518034F855DD09A9ED@aiexchange.ai.aiinet.com>
In-Reply-To: <C0170D0AF1277849A4B4518034F855DD09A9ED@aiexchange.ai.aiinet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linux-usb-devel@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
Subject: Re: [linux-usb-devel] USB host on Freescale MPC880
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dayton, Dean wrote:
> I need to provide a USB host interface on a propietary board using a
> Freescale (Motorola) MPC880. The MPC880 has a USB implemented in the
> CPM, but I haven't found any Linux support for it. Can anyone point me
> to existing drivers? Does anyone know of any problems that would/should
> prevent me from using the MPC880's USB interface?
> 
> Thanks

Greetings Dean *list*.

There are some propiatery drivers... but... it's an oxymoron, to pay 
licensing fees for Linux... I'd sooner eat nails then use the propiatery 
offerings, to be quite honest, I'd have to quit my job before being 
associated with such a thing.

Right now the Freescale 870-885 has minimal support in Linux, but, I do 
have some patches for a 2.4.x which map out this family of chip's memory 
map as per the specification and I have a very primitive USB loopback 
tester working for this architecture. Said patches are not really ready 
for public consumption, not to mention only being usable on a 2.4.

A propiatery board being developed by my company wants USB host 
support... and I'm fairly confident I can do that... and hopefully I can 
get some serious development work done on this over the next three to 
four months and release a patch/(s) for public consumption.

I estimate it will take another four months to get USB host working 
properly and perhaps a month to get USB-device support working properly 
(touch wood on both counts), I'm not sure about the required development 
time on that to be honest... but, if I don't get it finished in time for 
our propiatery board, the powers that be in my company will use a 
propiatery Linux offering... and I'll have to resign on the grounds of 
being an Open Source Evangalist ! I need to eat/pay rent... so I really 
need to get this board + USB working. *grin*.

Are you guys planning on devoting any development effort to hardware 
support of this freescale part ? If so, would it be prudent to 
co-ordinate the development effort ?

Bryan


This message (including any attachments) is confidential and may be privileged. If you have received it by mistake please notify the sender by return e-mail and delete this message from your system. Any unauthorised use or dissemination of this message in whole or in part is strictly prohibited. Please note that e-mails are susceptible to change.  Imetrex Technologies Ltd shall not be liable for the improper or incomplete transmission of the information contained in this communication nor for any delay in its receipt or damage to your system. Imetrex Technologies Ltd does not guarantee that the integrity of this communication has been maintained nor that this communication is free of viruses, interceptions or interference. This communication does not create or modify any contract, and unless otherwise stated, is not intended to be contractually binding.  Views or opinions expressed in this e-mail message are those of the author only.
