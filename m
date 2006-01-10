Return-Path: <peter.ryser@xilinx.com>
Received: from outbound1-ash-R.bigfish.com (outbound-ash.frontbridge.com
	[206.16.192.249])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2DE91688DC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jan 2006 09:11:59 +1100 (EST)
Message-ID: <43C430E2.60905@xilinx.com>
Date: Tue, 10 Jan 2006 14:10:42 -0800
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?Paula_Saame=F1o?= <gnathita@gmail.com>
References: <259581790601100820s42d1a311ye40bfcf4ba6c9bd5@mail.gmail.com>
In-Reply-To: <259581790601100820s42d1a311ye40bfcf4ba6c9bd5@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Error: Three ML403 boards
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Paula,

please verify that you are not running into the problem described in=20
Xilinx Answer Record 22179=20
(http://www.xilinx.com/xlnx/xil_ans_display.jsp?iLanguageID=3D1&iCountryI=
D=3D1&getPagePath=3D22179).

- Peter


Paula Saame=F1o wrote:

> Hello,
>
> I have 3 Xilinx ML403 boards. I have implemented a 2.4 kernel with a=20
> basic configuration, with network support, systemACE, IIC... and it=20
> works perfectly in one of them.
>
> However, when I put the ACE card, without making any change, in other=20
> ML403 board, it does not work. The .ace file is loaded ok but then the=20
> network leds (6 leds) start blinking and nothing else happens.
>
> I have tried with two ML403 different boards, and I have no idea of=20
> where the problem is. They should work in the same way, don't they?
>
> Any help would be great.
>
> Also, I am trying to load a 2.6 kernel, but I am still on the way. I=20
> will let you know if I get it working.
>
> Thanks a lot!
> Paula
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
