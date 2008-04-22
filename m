Return-Path: <andre.schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 14893DE38A
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 03:36:50 +1000 (EST)
Message-ID: <480E2230.2030601@matrix-vision.de>
Date: Tue, 22 Apr 2008 19:36:48 +0200
From: Andre Schwarz <andre.schwarz@matrix-vision.de>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Question on MPC83xx interrupts
References: <480E1939.6000701@matrix-vision.de>
	<20080422172306.GA17992@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080422172306.GA17992@ld0162-tx32.am.freescale.net>
Content-Type: multipart/alternative;
	boundary="------------020808060905040308040308"
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
--------------020808060905040308040308
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Scott Wood schrieb:
> On Tue, Apr 22, 2008 at 06:58:33PM +0200, Andre Schwarz wrote:
>   
>> I wonder if the IRQ number should match the vector of the datasheet ... 
>> giving :
>>     
>
> No.  The numbers in /proc/interrupts are virtual IRQ numbers, which are a
> purely Linux-internal construct.
>
> -Scott
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>   
Scott,

thanks - any Idea how to figure out where the BAD comes from ?
Is it simply an unhandled/unacked one ?


regards,
Andre


MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner

--------------020808060905040308040308
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
 cite="mid:20080422172306.GA17992@ld0162-tx32.am.freescale.net"
 type="cite">
  <pre wrap="">On Tue, Apr 22, 2008 at 06:58:33PM +0200, Andre Schwarz wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I wonder if the IRQ number should match the vector of the datasheet ... 
giving :
    </pre>
  </blockquote>
  <pre wrap=""><!---->
No.  The numbers in /proc/interrupts are virtual IRQ numbers, which are a
purely Linux-internal construct.

-Scott
_______________________________________________
Linuxppc-dev mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-dev">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a>
  </pre>
</blockquote>
Scott,<br>
<br>
thanks - any Idea how to figure out where the BAD comes from ?<br>
Is it simply an unhandled/unacked one ?<br>
<br>
<br>
regards,<br>
Andre<br>
<BR>

MATRIX VISION GmbH, Talstraße 16, DE-71570 Oppenweiler  - Registergericht: Amtsgericht Stuttgart, HRB 271090
Geschäftsführer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
<BR>
</body>
</html>

--------------020808060905040308040308--
