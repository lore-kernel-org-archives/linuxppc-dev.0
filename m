Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64D64B7D6F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  3 May 2010 22:35:28 +1000 (EST)
Subject: Re: [PATCH 3/3] ptp: Added a clock that uses the eTSEC found on the
	MPC85xx.
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100503062617.GA3310@riccoc20.at.omicron.at>
Date: Mon, 3 May 2010 07:35:18 -0500
Message-Id: <9A24C06D-CCBF-4E2F-BBD6-A17B83571023@kernel.crashing.org>
References: <20100429092005.GA6727@riccoc20.at.omicron.at>
	<FFD6BE31-AF2B-4D44-9751-61DB06327DBD@kernel.crashing.org>
	<20100503062617.GA3310@riccoc20.at.omicron.at>
To: Richard Cochran <richardcochran@gmail.com>
Cc: Sandeep Gopalpet <Sandeep.Kumar@freescale.com>,
	Netdev <netdev@vger.kernel.org>,
	devicetree-discuss <devicetree-discuss@ozlabs.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 3, 2010, at 1:26 AM, Richard Cochran wrote:

> On Sat, May 01, 2010 at 11:36:12AM -0500, Kumar Gala wrote:
>> Is there a binding document that describes this node you are adding?
> 
> No, but I will add one to Documentation/powerpc/dts-bindings.

Please do so we can review and comment.

- k
