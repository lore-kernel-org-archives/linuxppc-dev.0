Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7ED16B7D2F
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Apr 2010 06:54:01 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o3RKrwES019154
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 13:53:58 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o3RL3S8H024501
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 16:03:28 -0500 (CDT)
Message-ID: <4BD74EE5.4020806@freescale.com>
Date: Tue, 27 Apr 2010 15:53:57 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/2] powerpc: add platform registration for ALSA
	SoC	drivers
References: <1272314980-23679-1-git-send-email-timur@freescale.com>
	<1272350168.24542.6.camel@pasglop>
	<20100427095440.GA15492@rakim.wolfsonmicro.main>
	<1272362955.24542.24.camel@pasglop>
	<j2pfa686aa41004271327v1658e33bgd170ecc9735f285b@mail.gmail.com>
	<20100427205004.GB15083@opensource.wolfsonmicro.com>
In-Reply-To: <20100427205004.GB15083@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, kumar.gala@freescale.com,
	linuxppc-dev@ozlabs.org, lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Mark Brown wrote:
> Hrm, the only issue that's been raised upstream is multi-CODEC (there
> are one or two other things that boil down to multi-CODEC, but nothing
> else I'm aware of).  If you schedule something please announce it here,
> I believe that UDS generally has arrangements for remote participation.

Keep in mind that the phandle-type properties can accept multiple phandles.  So for instance, if I had two codecs attached to an SSI, the SSI node would look like this:

	ssi@16000 {
		compatible = "fsl,mpc8610-ssi";
		...
		codec-handle = <&cs4270_1 &cs4270_2>;
	};

-- 
Timur Tabi
Linux kernel developer at Freescale
