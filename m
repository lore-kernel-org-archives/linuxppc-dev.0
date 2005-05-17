Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id D2643679F0
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 19:49:42 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4H9sTMs024115
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 17 May 2005 12:54:30 +0300 (EEST)
Message-ID: <4289BD01.5080805@intracom.gr>
Date: Tue, 17 May 2005 12:44:33 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: "Bryan O'Donoghue" <typedef@eircom.net>
References: <20050517081558.74BA0C1512@atlas.denx.de>
	<4289A635.5000509@intracom.gr> <4434E283.3000201@eircom.net>
In-Reply-To: <4434E283.3000201@eircom.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC885 - USB HCI drivers.
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
> Pantelis Antoniou wrote:
> 
> 
>>Well I have USB host drivers for both 8xx & 82xx working.
> 
> 
> Speaking of which... would it not be a good idea, to get these comitted
> to the 2.6 tree... at some stage ... at least to stop people
> periodically posting to this list... saying "Dear all have spent 2
> months, writing code for m8xx_hci drivers", when it's a needless
> replication of effort ?
> 

Well, they are too hideous for human eyes :)

> 
>>However I use them connected to a specific peripheral
>>so I don't know how well they fare when used as a PC
>>style USB host controller.
> 
> 
> Also, one easy way to find out, how well or badly said code performs, in
> hetrogenous environments, is to... suck it and see.
> 
> As I was attempting to intimate above, I'm sure there'd be a legion of
> eager people to debug, modify and recode such drivers, if there lived in
> an obvious place... in the 2.6 tree.
> 
> Just my €0.02.
> 

Also they're 2.4 only :)

I'll try to clean them up and post them sometime this week.

But I don't have time left to hack them for 2.6. I'll need
vict^H^H^Holunteers to do it...

Regards

Pantelis


> --
> 
> Best,
> Bryan
> 
> 
