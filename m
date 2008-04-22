Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id B1000DE274
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 04:51:25 +1000 (EST)
Message-ID: <480E33AB.5050904@matrix-vision.de>
Date: Tue, 22 Apr 2008 20:51:23 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Question on MPC83xx interrupts
References: <480E1939.6000701@matrix-vision.de>	<20080422172306.GA17992@ld0162-tx32.am.freescale.net>	<480E2230.2030601@matrix-vision.de>
	<20080422174208.GB18076@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080422174208.GB18076@ld0162-tx32.am.freescale.net>
Content-Type: multipart/alternative;
	boundary="------------090305090209000909080106"
Cc: linux-ppc list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090305090209000909080106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Scott Wood schrieb:
> On Tue, Apr 22, 2008 at 07:36:48PM +0200, Andre Schwarz wrote:
>   
>> thanks - any Idea how to figure out where the BAD comes from ?
>> Is it simply an unhandled/unacked one ?
>>     
>
> It generally happens when an interrupt is requested, and the core takes
> the exception, but then the interrupt source deasserts itself.
>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   
So this is not bad at all if you have a device with self-clearing 
interrupts ...

Thanks,
Andre


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------090305090209000909080106
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Scott Wood schrieb:
<blockquote
 cite="mid:20080422174208.GB18076@ld0162-tx32.am.freescale.net"
 type="cite">
  <pre wrap="">On Tue, Apr 22, 2008 at 07:36:48PM +0200, Andre Schwarz wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">thanks - any Idea how to figure out where the BAD comes from ?
Is it simply an unhandled/unacked one ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It generally happens when an interrupt is requested, and the core takes
the exception, but then the interrupt source deasserts itself.

-Scott
_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a>
  </pre>
</blockquote>
So this is not bad at all if you have a device with self-clearing
interrupts ...<br>
<br>
Thanks,<br>
Andre<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------090305090209000909080106--
