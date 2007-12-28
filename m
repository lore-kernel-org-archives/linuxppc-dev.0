Return-Path: <SRS0=Jm3s=RT=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 23283DDE0C
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Dec 2007 06:18:08 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: External int in dts
Date: Fri, 28 Dec 2007 20:12:56 +0100
References: <47753CD3.3000209@pikatech.com>
In-Reply-To: <47753CD3.3000209@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200712282012.56516.sr@denx.de>
Cc: Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 28 December 2007, Sean MacLennan wrote:
> I have an FPGA which uses external int 1, which is interrupt 24 on UIC0.
> I tried the following entry in various places:
>
>         FPGA0: fpga {
>             compatible = "pika,fpga";
>             interrupts = <18 4>;

Is the interrupt level sensitive and active high? Then "4" is correct here. 
But if it is active low then you should use "8" here".

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
