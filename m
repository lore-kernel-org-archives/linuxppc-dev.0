Return-Path: <kalle.pokki@iki.fi>
Received: from smtp2.song.fi (smtp2.song.fi [194.100.2.122])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1A05F68467
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Oct 2005 17:04:22 +1000 (EST)
Message-ID: <4340D7EF.2040709@iki.fi>
Date: Mon, 03 Oct 2005 09:04:15 +0200
From: Kalle Pokki <kalle.pokki@iki.fi>
MIME-Version: 1.0
To: Dan Malek <dan@embeddedalley.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85946A@ismail.innsys.innovsys.com>
	<4333DF04.3000908@iki.fi> <43395322.1080407@iki.fi>
	<384d09b865d454875c447cc02c89d001@embeddedalley.com>
	<4339AD01.30708@iki.fi>
	<714c16295fbfa97caafd1d0aa3a5932e@embeddedalley.com>
	<433A6E6D.4070403@iki.fi> <433BDCE7.2060206@iki.fi>
	<20050930142218.348041d6.ajz@cambridgebroadband.com>
	<2c578118c5d984e6e87ac3c073469866@embeddededge.com>
	<433D9BCE.5000909@iki.fi>
	<6eac69d46b656d812783d81a6ebeac84@embeddededge.com>
	<433E2530.7090503@iki.fi>
	<26a6f673ac9438729eccfe0c376c6b3d@embeddedalley.com>
In-Reply-To: <26a6f673ac9438729eccfe0c376c6b3d@embeddedalley.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: CPM2 early console
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan Malek wrote:

> What about just trying to boot the new kernel from PlanetCore boot rom?


I do use PlanetCore to boot the system. Basically the only funtionality 
in my own custom boot loader with this board is to carry the image of 
the Linux kernel, decompress, and launch it. I have disabled all the 
initialisation code since it was previously written for another board, 
and PlanetCore does all the initialisations anyway. I didn't care to 
erase PlanetCore from the flash just yet, since I can just as well 
develop the real initialisations later with the custom board.

PlanetCore itself is not usable for booting any other Linux kernel than 
the pre-installed one. It just allows me to launch some launcher of the 
Linux kernel... Probably it's the launcher that does the tricks to make 
Linux run correctly.

> Of course, if you are doing your own boot rom and have a board to 
> bring up,
> you should have invested in something like a BDI2000 long ago because 
> it will
> have paid for itself many times over by the time you are done :-)  It 
> would have
> also allowed you to debug this problem rather quickly.
>
You are right, this would be a lot easier with a good debugger. I just 
have delayed purchasing it since I wasn't previously sure if we'd use 
the PowerQUICC II family or not. I already have Lauterbach for 8xx, but 
the Linux community seems to prefer the BDI2000. Do you know if it fits 
better in Linux development? At least it seems to be a lot less 
expensive than a new Lautherbach license for the 82xx family.
