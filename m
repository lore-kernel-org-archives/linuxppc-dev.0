Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BA2E9B7CDA
	for <linuxppc-dev@ozlabs.org>; Sun, 17 Jan 2010 18:22:27 +1100 (EST)
Message-ID: <4B52BA71.3070206@grandegger.com>
Date: Sun, 17 Jan 2010 08:21:21 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: nanda <nanda74pg@rediffmail.com>
Subject: Re: DTS file reference for FSL UPM NAND for MPC832x
References: <20100116170224.29250.qmail@f5mail-236-241.rediffmail.com>
In-Reply-To: <20100116170224.29250.qmail@f5mail-236-241.rediffmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

nanda wrote:
> Hi,
>    Iam looking for any references for the dts (device tree source) file which implements freescale's  UPM based NAND driver connected to NAND flash. (it uses the individual gpio connected to R/B pin)

The following links might be useful:

http://lxr.linux.no/#linux+v2.6.32/Documentation/powerpc/dts-bindings/fsl/upm-nand.txt
http://lxr.linux.no/#linux+v2.6.32/arch/powerpc/boot/dts/mpc836x_rdk.dts#L407

Wolfgang.
