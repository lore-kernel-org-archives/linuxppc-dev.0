Return-Path: <dan@embeddedalley.com>
Received: from smtp103.biz.mail.re2.yahoo.com (smtp103.biz.mail.re2.yahoo.com
	[68.142.229.217]) by ozlabs.org (Postfix) with SMTP id EAD87679FB
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Jul 2006 01:56:34 +1000 (EST)
In-Reply-To: <20060701105337.3fcd5f0f@White64>
References: <13853799.1151694631780.JavaMail.root@ps13>
	<20060701105337.3fcd5f0f@White64>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4B4E00BA-B6AB-4F0F-A711-311C5A5496DF@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: rs232 endianness on PPC
Date: Sat, 1 Jul 2006 11:56:30 -0400
To: White <white@from-b.org>
Cc: "tauanna@tiscali.it" <tauanna@tiscali.it>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 1, 2006, at 4:53 AM, White wrote:

> PowerPC is only Byte swaped, not bit-swaped :)

PowerPC isn't byte swapped, the other world is :-)

> The second: I think the bitorder on the rs232 is standarized :) and
> should be the same ... :)

RS-232 is LS bit first.


	-- Dan
