Return-Path: <sr@denx.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id E1ECFDDF90
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jun 2008 18:29:41 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: - Reyneke <reynekejunk@hotmail.com>
Subject: Re: FP and signal 4
Date: Thu, 5 Jun 2008 10:29:36 +0200
References: <BAY101-W2A5F2B80B271BD10DE9BBBEB50@phx.gbl>
	<200806050659.30499.sr@denx.de>
	<BAY101-W3227AB825957D1D453830CBEB40@phx.gbl>
In-Reply-To: <BAY101-W3227AB825957D1D453830CBEB40@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806051029.36558.sr@denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 05 June 2008, - Reyneke wrote:
> Aaah - looks like that was it. Works OK now with CONFIG_MATH_EMULATION
> un-set.

Great.

I hope "-b 0" is set by default in recent dtc versions. If not we should 
really do this (I already mentioned this to David Gibson before). This is a 
nasty bug on 440EPx which was not so easy to find.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
