Return-Path: <Andre.Schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 724BBDDDCA
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Dec 2008 06:39:13 +1100 (EST)
Message-ID: <49343DC2.3070601@matrix-vision.de>
Date: Mon, 01 Dec 2008 20:40:50 +0100
From: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <Andre.Schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: i2c-mpc clocking scheme
References: <492EB606.9020703@matrix-vision.de>
	<ed82fe3e0811270724t26d2a8e2v233143722eb8587f@mail.gmail.com>
	<492EC031.9000802@matrix-vision.de>
	<Pine.LNX.4.64.0811281255001.12483@t2.domain.actdsltmp>
	<4933FBC6.50100@freescale.com>
In-Reply-To: <4933FBC6.50100@freescale.com>
Content-Type: multipart/alternative;
	boundary="------------010802070302050105080903"
Cc: linuxppc-dev@ozlabs.org, Trent Piepho <tpiepho@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010802070302050105080903
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Timur Tabi wrote:
> Trent Piepho wrote:
>
>   
>> Seems like it should keep the clock registers at what u-boot set them too.
>>     
>
> Or we could have U-Boot put the i2c clock frequency into the I2C node, and let
> the driver program the hardware again.  That would keep the ugliness in U-Boot.
>
>   
Wouldn't it be easier to omit frequency re-programming at all ?
Maybe configurable for non U-Boot users ...


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------010802070302050105080903
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Timur Tabi wrote:
<blockquote cite="mid:4933FBC6.50100@freescale.com" type="cite">
  <pre wrap="">Trent Piepho wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">Seems like it should keep the clock registers at what u-boot set them too.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Or we could have U-Boot put the i2c clock frequency into the I2C node, and let
the driver program the hardware again.  That would keep the ugliness in U-Boot.

  </pre>
</blockquote>
Wouldn't it be easier to omit frequency re-programming at all ?<br>
Maybe configurable for non U-Boot users ...<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------010802070302050105080903--
