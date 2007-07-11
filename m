Return-Path: <sr@denx.de>
Received: from cg-p07-fb.rzone.de (cg-p07-fb.rzone.de [81.169.146.215])
	by ozlabs.org (Postfix) with ESMTP id 907E7DDDFC
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 00:28:01 +1000 (EST)
Received: from mo-p07-ob.rzone.de (klopstock-mo-p07-ob.mail [192.168.63.178])
	by charnel-fb-03.store (RZmta 8.2) with ESMTP id i040b7j6BCPvS1
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Jul 2007 16:27:59 +0200 (MEST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC][PATCH 6/8] Walnut DTS
Date: Wed, 11 Jul 2007 16:26:52 +0200
References: <1184161957.32199.52.camel@weaponx.rchland.ibm.com>
	<1184162389.32199.65.camel@weaponx.rchland.ibm.com>
In-Reply-To: <1184162389.32199.65.camel@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707111626.52676.sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 11 July 2007, Josh Boyer wrote:
> +		PowerPC,405GP@0 {
> +			device_type = "cpu";
> +			reg = <0>;
> +			clock-frequency = <bebc200>; /* Filled in by zImage */
> +			timebase-frequency = <0>; /* Filled in by zImage */
> +			i-cache-line-size = <20>;
> +			d-cache-line-size = <20>;
> +			i-cache-size = <8000>;
> +			d-cache-size = <8000>;

405 platforms have 16k cache at most.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
