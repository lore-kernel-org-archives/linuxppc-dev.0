Return-Path: <lagrange@fr.oleane.com>
Received: from smtp7.clb.oleane.net (smtp7.clb.oleane.net [213.56.31.27])
	by ozlabs.org (Postfix) with ESMTP id E601B67A2C
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  3 Feb 2005 20:31:31 +1100 (EST)
From: "Laurent Lagrange" <lagrange@fr.oleane.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Thu, 3 Feb 2005 10:35:25 +0100
Message-ID: <000701c509d3$b2d99300$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050202184143.GC17450@tuxdriver.com>
Subject: RE: MPC8560 TCP/IP Offloading (SDP)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

> TOE is not a popular topic in the Linux networking community.
> Actually, it is a popular topic for discussion, but not a popular
> solution for implementation.  I guess the point is that there is no
> TOE code for Linux, at least not in any official sense.
> That said, this is the first I've heard of SDP.  Can you point me to
> where I can get more information?

Thanks for the point of view.
It seems that SDP concept comes from Microsoft Sockets Direct Technology
and be used on Intel Infiniband architecture.

The following sites seem to be interesting entry points 
(advice from a newbie on this subject :-)):
http://infiniband.sourceforge.net/archive/LinuxSAS_SDP.htm
http://www.microsoft.com/mscorp/ip/standards/

Laurent
