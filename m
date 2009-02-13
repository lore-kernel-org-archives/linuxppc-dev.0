Return-Path: <jhautbois@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 2BEE3DDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 20:25:45 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id l26so343085fgb.39
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 01:25:42 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090212222403.GA10344@ld0162-tx32.am.freescale.net>
References: <8cad0aa0902120123p27cfe32fg6bf08d458178c937@mail.gmail.com>
	<49940265.1020700@vastech.co.za>
	<8cad0aa0902120310g44a3bf3cla4ffa94ea9bf5dc6@mail.gmail.com>
	<20090212133037.GA3651@yookeroo.seuss>
	<8cad0aa0902120536p3303322cvf9a7307391d195b9@mail.gmail.com>
	<49942D68.7080706@vastech.co.za>
	<8cad0aa0902120626v733011a5u669fc30096565d86@mail.gmail.com>
	<20090212222403.GA10344@ld0162-tx32.am.freescale.net>
Date: Fri, 13 Feb 2009 10:25:42 +0100
Message-ID: <8cad0aa0902130125h496f712bh809cfb1d45d6ad17@mail.gmail.com>
Subject: Re: [MPC8272ADS]Problem adding flash partitions inside the device
	tree
From: Jean-Michel Hautbois <jhautbois@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

2009/2/12 Scott Wood <scottwood@freescale.com>:
> On Thu, Feb 12, 2009 at 03:26:58PM +0100, Jean-Michel Hautbois wrote:
>> I think that the problem is in the reg part, but I can't understand why.
>> Isn't it the RAM mpping of my MTD that is the first address ?
>
> No, it's the offset into the chipselect.
>
> -Scott
>

OK.
What means the word #adress-cells BTW ?
When should I have 1, 2 or anything else ?

Regards,
JM
