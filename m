Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 5344EDE014
	for <linuxppc-dev@ozlabs.org>; Thu, 14 May 2009 19:09:42 +1000 (EST)
Date: Thu, 14 May 2009 11:09:30 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Simon Richter <Simon.Richter@hogyros.de>
Subject: Re: [RFC] How to allow selecting mv643xx_eth on Pegasos again
Message-ID: <20090514090930.GA24887@iram.es>
References: <20090514064836.GA21486@iram.es>
	<20090514085902.GA30546@honey.hogyros.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090514085902.GA30546@honey.hogyros.de>
Cc: LinuxPPC <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 14, 2009 at 10:59:02AM +0200, Simon Richter wrote:
> Hi,
> 
> I just tried upgrading my PegasosII to 2.6.29, and found that the Marvell
> driver shows two Ethernet ports now, one with a MAC address ending in
> ...:de:ad:01 (which is the port that is not wired to the outside), and the
> other one with 00:00:00:00:00:00.
> 
> I think some sort of Pegasos specific hack is needed.

For that specific problem othere is the patch that I submitted to this 
mailing list, which was merged early into 2.6.30.

	Gabriel
