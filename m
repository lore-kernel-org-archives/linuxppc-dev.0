Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 2081CDE0DB
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 01:58:53 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Kumar Gala <galak@kernel.crashing.org>,
	Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] cpm2: Round the baud-rate clock divider to the nearest
	integer.
Date: Thu, 15 Jan 2009 15:58:50 +0100
References: <200811201332.24061.laurentp@cse-semaphore.com>
	<200901151418.28882.laurentp@cse-semaphore.com>
	<98B0EC36-C1AE-44F0-98CC-F1AED0B9E299@kernel.crashing.org>
In-Reply-To: <98B0EC36-C1AE-44F0-98CC-F1AED0B9E299@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901151558.50816.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org, vbordug@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 15 January 2009 15:42:14 Kumar Gala wrote:
> On Jan 15, 2009, at 7:18 AM, Laurent Pinchart wrote:
> >
> > 2.6.29-rc1 is out and I haven't seen the patch being applied
> > anywhere. Is there any blocking issue ?
>
> I wasn't sure if you and Scott had come to resolution on the rounding
> issue.

I think we have. Scott, can you confirm ?

Best regards,

-- 
Laurent Pinchart
CSE Semaphore Belgium

Chaussee de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
F +32 (2) 387 42 75
