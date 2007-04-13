Return-Path: <Leonid@a-k-a.net>
Received: from mis011-1.exch011.intermedia.net
	(mis011-1.exch011.intermedia.net [64.78.21.128])
	by ozlabs.org (Postfix) with ESMTP id E87ECDDEBF
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 14 Apr 2007 03:05:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: HOTO start with linux 2.6.* and ML403
Date: Fri, 13 Apr 2007 10:04:17 -0700
Message-ID: <406A31B117F2734987636D6CCC93EE3C0149F16A@ehost011-3.exch011.intermedia.net>
In-Reply-To: <9979404.post@talk.nabble.com>
References: <9939239.post@talk.nabble.com><BAY115-W21FFB4DA2861035BC20B77B25F0@phx.gbl><461E50B3.6060105@ru.mvista.com>
	<9979404.post@talk.nabble.com>
From: "Leonid" <Leonid@a-k-a.net>
To: "Mirek23" <miroslaw.dach@psi.ch>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday, April 13, 2007 6:53 AM Mirek wrote:
> In the Kernel xparameters_ml403.h I did not find any reference to the
> XILINX_TEMAC network interface.=20

It is not there since patch I've sent you (provided by Lorentz Kolb) is
designed to work with standard ML403 EDK design which has EMAC, not
TEMAC. I didn't try to use TEMAC on ML403 though I'm using it on my
proprietary Virtex4 based board.=20

Answers on your other questions see in my personal e-mail.

Leonid.
