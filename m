Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 46E4067A62
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 18:27:09 +1100 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j0J73UrQ029587
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Jan 2005 09:03:34 +0200 (EET)
Message-ID: <41EE03FF.3040609@intracom.gr>
Date: Wed, 19 Jan 2005 08:53:51 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: "Bryan O'Donoghue" <bryano@europlex.ie>
References: <C0170D0AF1277849A4B4518034F855DD09A9ED@aiexchange.ai.aiinet.com>
	<41ED478A.6020303@europlex.ie>
In-Reply-To: <41ED478A.6020303@europlex.ie>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org, "Dayton, Dean" <deand@aiinet.com>,
	linux-usb-devel@lists.sourceforge.net
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

Bryan O'Donoghue wrote:
> Dayton, Dean wrote:
> 
>> I need to provide a USB host interface on a propietary board using a
>> Freescale (Motorola) MPC880. The MPC880 has a USB implemented in the
>> CPM, but I haven't found any Linux support for it. Can anyone point me
>> to existing drivers? Does anyone know of any problems that would/should
>> prevent me from using the MPC880's USB interface?
>>
>> Thanks
> 
> 
> Greetings Dean *list*.
> 
> There are some propiatery drivers... but... it's an oxymoron, to pay 
> licensing fees for Linux... I'd sooner eat nails then use the propiatery 
> offerings, to be quite honest, I'd have to quit my job before being 
> associated with such a thing.
> 
> Right now the Freescale 870-885 has minimal support in Linux, but, I do 
> have some patches for a 2.4.x which map out this family of chip's memory 
> map as per the specification and I have a very primitive USB loopback 
> tester working for this architecture. Said patches are not really ready 
> for public consumption, not to mention only being usable on a 2.4.
> 
> A propiatery board being developed by my company wants USB host 
> support... and I'm fairly confident I can do that... and hopefully I can 
> get some serious development work done on this over the next three to 
> four months and release a patch/(s) for public consumption.
> 
> I estimate it will take another four months to get USB host working 
> properly and perhaps a month to get USB-device support working properly 
> (touch wood on both counts), I'm not sure about the required development 
> time on that to be honest... but, if I don't get it finished in time for 
> our propiatery board, the powers that be in my company will use a 
> propiatery Linux offering... and I'll have to resign on the grounds of 
> being an Open Source Evangalist ! I need to eat/pay rent... so I really 
> need to get this board + USB working. *grin*.
> 
> Are you guys planning on devoting any development effort to hardware 
> support of this freescale part ? If so, would it be prudent to 
> co-ordinate the development effort ?
> 
> Bryan
> 

I have a fairly hacked over version of the original USB host driver that
works for 87x/88x.

Are you interested?

Regards

Pantelis
