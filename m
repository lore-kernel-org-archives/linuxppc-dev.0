Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17746.21876.387969.557614@cargo.ozlabs.ibm.com>
Date: Thu, 9 Nov 2006 09:08:52 +1100
From: Paul Mackerras <paulus@samba.org>
To: Jake Moilanen <moilanen@austin.ibm.com>
Subject: Re: [PATCH] client-architecture termination
In-Reply-To: <1163016748.9913.273.camel@goblue>
References: <1163016748.9913.273.camel@goblue>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jake Moilanen writes:

> Firmware is crashing during CAS parsing.  It appears that a portion of
> Will's patch got dropped.

Indeed it got dropped, because it would make the contents of our
ibm_architecture_vec incorrect according to PAPR.  The platform
architects confirmed some time ago that what we have is correct, and
the bug is in firmware - and this was communicated to the firmware
developers.

This came up a while ago; I'm surprised that firmware hasn't fixed
their bug yet.  What firmware level are you seeing this problem with?

Paul.
