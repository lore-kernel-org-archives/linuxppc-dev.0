Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6ACBCDE03E
	for <linuxppc-dev@ozlabs.org>; Tue, 19 May 2009 17:01:38 +1000 (EST)
Message-Id: <58E6156F-8A23-4C86-A50D-C04283430684@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1242683444.16901.1.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: fs_enet build breakage
Date: Tue, 19 May 2009 01:59:24 -0500
References: <1242630064.18075.48.camel@pasglop>
	<9732983B-B67C-4831-BBAB-65472BE0F279@kernel.crashing.org>
	<20090518172016.GB18620@b07421-ec1.am.freescale.net>
	<1242683444.16901.1.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, Kumar Gala <galak@gate.crashing.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 18, 2009, at 4:50 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2009-05-18 at 12:20 -0500, Scott Wood wrote:
>>> I'm pretty sure the driver changes to address this are in dave's
>> net-
>>> next tree.
>>
>> Won't this break git bisect?
>>
>> Not to mention anyone trying to use your tree now...
>
> Right, though if you have the commit ID in DaveM tree, I can work with
> him to sort out that driver, for example by having the same commit in
> my tree.

As discussed on IRC, its easier to modify the commit that cause the  
issue to drop removing IMAP_ADDR for cpm1 devices for now.  I'll  
generate a separate patch for us to deal w/during the merge window  
for .31

- k
