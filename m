Return-Path: <mlan@cpu.lu>
Received: from smtp-out.coditel.net (smtp-out.coditel.net [212.95.66.33])
	by ozlabs.org (Postfix) with ESMTP id C1BA467B8F
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 06:40:25 +1000 (EST)
Date: Sat, 19 Aug 2006 22:10:46 +0200 (CEST)
From: Mich Lanners <mlan@cpu.lu>
Subject: Re: HDLC drivers on 8260
To: alexfestss@hotmail.com
In-Reply-To: <BAY106-F227AE7DF98822643447FA7DB430@phx.gbl>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E1GEX9g-0005UG-SN@owl.grunz.lu>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

On  19 Aug, this message from Alejandro C echoed through cyberspace:
> I've just started developing a driver to use the four SCCs (CPM of the 
> Motorola
> MPC8260) in the HDLC mode. I've found references to a HDLC driver
> somewhere on the internet, but I haven't been able to locate the
> source code. Does anyone know where to find this or something else I
> can use as an example/starting point?

I don't know a thing about the SCCs in the MPC8260, but you may want to
have a look at the Cyclades PC300 driver in the kernel. It does HDLC
(but I don't remember whether it's the PC300 driver or a generic HDLC
driver in the kernel). What HDLC do you wnat to implement? There is no
generic HDLC per se, but different framings using a HDLC-like framing.
Examples would be Cisco's IP over HDLC, or PPP.

For Cisco's HDLC, I added IP address autoconfiguration to the PC300
(submitted to the maintainer, but never found it's way into the official
kernels).

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "
