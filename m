Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id 7C3C9DDED5
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 17:35:58 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 2/2] [POWERPC] Add L2 cache node to AMCC Taishan dts file
Date: Wed, 19 Mar 2008 07:30:40 +0100
References: <1205847466-17854-1-git-send-email-sr@denx.de>
	<23bc1271d080c41ab54a4917d256a76b@kernel.crashing.org>
In-Reply-To: <23bc1271d080c41ab54a4917d256a76b@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200803190730.41058.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 18 March 2008, Segher Boessenkool wrote:
> > +	L2C0: l2c@30 {
> > +		compatible = "ibm,l2-cache-440gx", "ibm,l2-cache";
> > +		dcr-reg = <20 8			/* Internal SRAM DCR's */
> > +			   30 8>;		/* L2 cache DCR's */
>
> The unit address is based on the _first_ entry in "reg".

I'll remove the unit address.

> No2 this 
> is "dcr-reg", but you don't really want to be more incompatible than
> necessary...

Sorry, I'm not sure what you're trying to tell me here.

Best regards,
Stefan
