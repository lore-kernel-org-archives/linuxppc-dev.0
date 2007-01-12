Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17831.7374.149397.133454@cargo.ozlabs.ibm.com>
Date: Fri, 12 Jan 2007 16:29:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: "Zhu Ebony-r57400" <ebony.zhu@freescale.com>
Subject: Re: [patch][0/5] powerpc: Add support to fully comply with IEEE-754
	standard
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E8169E3@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E8169E3@zch01exm20.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zhu Ebony-r57400 writes:

> This series of patch add support to fully comply with IEEE-754 standard
> for E500/E500v2 core when hardware floating point compiling is used.

Your patch descriptions need to explain in detail in what way the
current code doesn't comply with the IEEE-754 standard, and what
approach you have taken to make it comply.  If there are alternative
approaches, explain why the approach you have taken is the best.

Thanks,
Paul.
