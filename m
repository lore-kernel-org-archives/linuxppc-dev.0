Return-Path: <tnt@246tNt.com>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89A8F68A0F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Jan 2006 09:21:42 +1100 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0TMLS49021930
	for <linuxppc-embedded@ozlabs.org>; Sun, 29 Jan 2006 23:21:29 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <43DD3FFC.3040608@246tNt.com>
Date: Sun, 29 Jan 2006 23:21:48 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: John Rigby <jcrigby@gmail.com>
Subject: Re: [PATCH] Add support for lite5200b board.
References: <43D65FE3.6080501@freescale.com> <43D66F54.8000404@246tNt.com>	
	<43D751F8.9060204@aotek.es> <43D807E0.1090206@246tNt.com>
	<4b73d43f0601261329n73971003n9217374a1cc2db6f@mail.gmail.com>
In-Reply-To: <4b73d43f0601261329n73971003n9217374a1cc2db6f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Txema Lopez <tlopez@aotek.es>, John Rigby <jrigby@freescale.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

John Rigby wrote:
> 
> 
> On 1/25/06, *Sylvain Munaut* <tnt@246tnt.com <mailto:tnt@246tnt.com>> wrote:
> 
> 
> 
>     Should apply fine on vanilla. My suggestion for now is take vanilla,
>     apply this patch, then the 2-3 patch from Andrey for BestComm and stuff.
> 
> 
> I was working on getting bestcomm and fec working, but forward porting
> my old 2.6.10 code to current is turning out to be more difficult than I
> expected.
> If you already have working code then I'll stop working on them.
> 
> Where are these patches?  I'm new to this list so I don't have much
> history.
> Would I find these patches in the archive?

Checkout (with git)

http://gitbits.246tNt.com/gitbits/linux-2.6-mpc52xx

then apply

http://gitbits.246tNt.com/patches/bcomm-to-split.diff

 (I haven't cleanly splitted it up yet and right now I must go, so it's
probably gonna be in the git tree this week, under the 'bestcomm' head ;)


Please report if it works fine on your board (both lite5200 and
lite5200b reports are welcome). I only did quick tests.



	Sylvain
