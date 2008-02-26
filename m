Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18371.60089.808367.553892@cargo.ozlabs.ibm.com>
Date: Tue, 26 Feb 2008 21:32:25 +1100
From: Paul Mackerras <paulus@samba.org>
To: Martin Langer <martin-langer@gmx.de>
Subject: Re: [PATCH] Fix for Freescale ppc cores: major revision detection
In-Reply-To: <20080211202933.GA3399@tuba>
References: <20080211202933.GA3399@tuba>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Martin Langer writes:

> Thanks for the hint. Inspired by that I did the logic the other way 
> round. So we have the same default cases as we had before and 
> additionally it will fit for the cores mentioned in the doc.

Care to resend this with a proper description and a Signed-off-by
line?

> +		switch (PVR_VER(pvr)) {
> +			case 0x8000:	/* 7441/7450/7451, Vger */
> +			case 0x8001:	/* 7445/7455, Apollo 6 */
> +			case 0x8002:	/* 7447/7457, Apollo 7 */
> +			case 0x8003:	/* 7447A, Apollo 7 PM */
> +			case 0x8004:	/* 7448, Apollo 8 */
> +			case 0x800c:	/* 7410, Nitro */

BTW, these case labels are all indented one tab too far.

Paul.
