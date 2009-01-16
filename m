Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 1B1DADE263
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 20:50:22 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Date: Fri, 16 Jan 2009 10:50:18 +0100
References: <200811201332.24061.laurentp@cse-semaphore.com>
	<20090115175456.GA11405@ld0162-tx32.am.freescale.net>
	<FA9675B0-0DC7-46DF-B2F5-A5370A15AF0A@kernel.crashing.org>
In-Reply-To: <FA9675B0-0DC7-46DF-B2F5-A5370A15AF0A@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901161050.18973.laurentp@cse-semaphore.com>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Vitaly Bordug <vbordug@ru.mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 January 2009 19:57:44 Kumar Gala wrote:
> On Jan 15, 2009, at 11:54 AM, Scott Wood wrote:
> > On Thu, Jan 15, 2009 at 03:58:50PM +0100, Laurent Pinchart wrote:
> >> On Thursday 15 January 2009 15:42:14 Kumar Gala wrote:
> >>> On Jan 15, 2009, at 7:18 AM, Laurent Pinchart wrote:
> >>>> 2.6.29-rc1 is out and I haven't seen the patch being applied
> >>>> anywhere. Is there any blocking issue ?
> >>>
> >>> I wasn't sure if you and Scott had come to resolution on the
> >>> rounding
> >>> issue.
> >>
> >> I think we have. Scott, can you confirm ?
> >
> > I think the patch is correct, and I need to look into why it gives me
> > problems on mpc8272ads (while solving similar issues on some other
> > boards).
>
> Ok.
>
> Laurent,
>
> Is this critical for 2.6.29 or ok if I queue for .30?

You can queue the patch for 2.6.30. Just don't forget this time ;-)

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
