Return-Path: <tnt@246tNt.com>
Received: from outmx005.isp.belgacom.be (outmx005.isp.belgacom.be
	[195.238.2.102]) by ozlabs.org (Postfix) with ESMTP id 7AFBC67A71
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 07:46:44 +1100 (EST)
Received: from outmx005.isp.belgacom.be (localhost [127.0.0.1])
	by outmx005.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j1GKkbak027300
	for <linuxppc-embedded@ozlabs.org>; Wed, 16 Feb 2005 21:46:39 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4213B111.4050905@246tNt.com>
Date: Wed, 16 Feb 2005 21:46:09 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Grant Likely <glikely@gmail.com>
References: <528646bc05021515486bd9f926@mail.gmail.com>
In-Reply-To: <528646bc05021515486bd9f926@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Lite5200 full duplex support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

>I'm using Sylvain's http://bkbits.246tnt.com:14690/linux-2.5-mpc52xx
>bk tree on a lite5200 evb.  I noticed that the FEC driver is hard
>coded to only support half duplex 10/100 auto-negotiation.  Is that
>intentional?  Are there any known problems with running full duplex?
>
>I modified the code to allow full duplex and I haven't observed any
>problems yet.  (w/ nfsroot and compiling apps on the target natively)
>
>Cheers,
>g.
>
>BTW, here's what I changed:
>drivers/net/fec_mpc52xx/fec_phy.c line 294 (phy_info_lxt971)
>from:
>        { mk_mii_write(MII_REG_ANAR, 0x0A1), NULL }, /* 10/100, HD */
>to:
>        { mk_mii_write(MII_REG_ANAR, 0x1E1), NULL }, /* 10/100, HD */
>
>  
>
I'm not sure actually. I also wondered and forgot to ask the author. I guess
I always tought there was a problem with it without checking.

Good to know it's working. Thanks

    Sylvain
