Return-Path: <peter.ryser@xilinx.com>
Received: from outbound2-cpk-R.bigfish.com (outbound-cpk.frontbridge.com
	[207.46.163.16])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 62E8567C8C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Aug 2006 02:53:08 +1000 (EST)
Message-ID: <44EDD947.3000105@xilinx.com>
Date: Thu, 24 Aug 2006 09:52:23 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Wade Maxfield <wmaxfield@gmail.com>
Subject: Re: MontaVista 2.6 Kernel support for Xilinx ML40x
References: <DADA32856852FC458E0F96B664A6F55E011E2423@kom-mailsrv1.kontron-modular.com>
	<45a1b53e0608240836l52ed51b5u309e31dd8486cc5b@mail.gmail.com>
In-Reply-To: <45a1b53e0608240836l52ed51b5u309e31dd8486cc5b@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="------------090305010208020506000003"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------090305010208020506000003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Wade,

are you sure that you did not build your hardware with evaluation cores 
of the licenses? If you are using the evaluation licenses the hardware 
(FPGA design) will stop working after a certain amount of time and you 
will see a lock-up.

- Peter


Wade Maxfield wrote:

>
>   I've got the LSP, and have booted it on the ML40X.
>  
>   In my opinion it is currently unstable, but that is my opinion.  
> I've not been able to keep it powered up for 24 hours without it 
> locking up on the RS232 serial terminal.  Also, running updatedb over 
> nfs causes it to abort with a kernel panic, although that might be an 
> interraction with the nfs server.  (Although even if the nfs server 
> dies (which it did not), I don't expect a kernel panic).
>
>    I have had it run over 6 hours without issue, so I expect subtle 
> memory leaks, not serious problems.
>
>
>
> On 8/24/06, Claus Gindhart < claus.gindhart@kontron.com 
> <mailto:claus.gindhart@kontron.com>> wrote:
>
>     Frank,
>
>     due to my understanding of the GPL (and i have already invested
>     some time
>     in understanding the various flavours of open source licences),
>     you should
>     contact Montavista, and ask them for the sources.
>
>     This board adaption is derivative work of the GPL Kernel, so the
>     result of
>     this work also falls under the GPL, and has to be made freely
>     available
>     under the terms of the GPL.
>
>     --
>     Mit freundlichen Gruessen / Best regards
>
>     Claus Gindhart
>     SW R&D
>     Kontron Modular Computers
>     phone :++49 (0)8341-803-374
>     mailto:claus.gindhart@kontron-modular.com
>     <mailto:claus.gindhart@kontron-modular.com>
>     http://www.kontron.com
>
>     -----BEGIN GEEK CODE BLOCK-----
>       Version: 3.1
>       GU d- s++:>++:+ a+ C++$ !U !P L++>$ E-- W+(-) N- o?
>       K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++
>       D-- G e++> h--- !r x+++
>     ------END GEEK CODE BLOCK------
>
>
>     -----Original Message-----
>     From:
>     linuxppc-embedded-bounces+claus.gindhart=kontron.com@ozlabs.org
>     <mailto:kontron.com@ozlabs.org>
>     [mailto:
>     linuxppc-embedded-bounces+claus.gindhart=kontron.com@ozlabs.org
>     <mailto:linuxppc-embedded-bounces+claus.gindhart=kontron.com@ozlabs.org>]
>     On Behalf Of Frank D Lombardo
>     Sent: Donnerstag, 24. August 2006 15:59
>     To: linuxppc-embedded@ozlabs.org <mailto:linuxppc-embedded@ozlabs.org>
>     Subject: MontaVista 2.6 Kernel support for Xilinx ML40x
>
>
>     I noticed that MontaVista now has their Pro 4.0 version (2.6 Kernel)
>     available for the Xilinx ML40x series of boards.  I would assume that
>     means driver support for at least most of the hardware on the boards.
>     Is this code that should be freely available?  How would one get a
>     copy
>     of these drivers?  I am interested in drivers for the ML403.
>
>     Thanks,
>     Frank
>     _______________________________________________
>     Linuxppc-embedded mailing list
>     Linuxppc-embedded@ozlabs.org <mailto:Linuxppc-embedded@ozlabs.org>
>     https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>     _______________________________________________
>     Linuxppc-embedded mailing list
>     Linuxppc-embedded@ozlabs.org <mailto:Linuxppc-embedded@ozlabs.org>
>     https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>     <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>
>
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

--------------090305010208020506000003
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Wade,<br>
<br>
are you sure that you did not build your hardware with evaluation cores
of the licenses? If you are using the evaluation licenses the hardware
(FPGA design) will stop working after a certain amount of time and you
will see a lock-up.<br>
<br>
- Peter<br>
<br>
<br>
Wade Maxfield wrote:<br>
<blockquote
 cite="mid45a1b53e0608240836l52ed51b5u309e31dd8486cc5b@mail.gmail.com"
 type="cite"><br>
&nbsp; I've got the LSP, and have booted it on the ML40X.<br>
&nbsp;<br>
&nbsp; In my opinion it is currently unstable, but that is my opinion.&nbsp; I've
not been able to keep it powered up for 24 hours without it locking up
on the RS232 serial terminal.&nbsp; Also, running updatedb over nfs causes
it to abort with a kernel panic, although that might be an interraction
with the nfs server.&nbsp; (Although even if the nfs server dies (which it
did not), I don't expect a kernel panic).
  <br>
  <br>
&nbsp;&nbsp; I have had it run over 6 hours without issue, so I expect subtle
memory leaks, not serious problems.<br>
  <br>
  <br>
  <br>
  <div><span class="gmail_quote">On 8/24/06, <b
 class="gmail_sendername">Claus Gindhart</b> &lt;
  <a href="mailto:claus.gindhart@kontron.com">claus.gindhart@kontron.com</a>&gt;
wrote:</span>
  <blockquote class="gmail_quote"
 style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Frank,<br>
    <br>
due to my understanding of the GPL (and i have already invested some
time<br>
in understanding the various flavours of open source licences), you
should<br>
contact Montavista, and ask them for the sources.<br>
    <br>
This board adaption is derivative work of the GPL Kernel, so the result
of<br>
this work also falls under the GPL, and has to be made freely available<br>
under the terms of the GPL.<br>
    <br>
--<br>
Mit freundlichen Gruessen / Best regards
    <br>
    <br>
Claus Gindhart<br>
SW R&amp;D<br>
Kontron Modular Computers<br>
phone :++49 (0)8341-803-374<br>
mailto:<a href="mailto:claus.gindhart@kontron-modular.com">claus.gindhart@kontron-modular.com</a><br>
    <a href="http://www.kontron.com">http://www.kontron.com</a><br>
    <br>
-----BEGIN GEEK CODE BLOCK-----<br>
&nbsp;&nbsp;Version: 3.1<br>
&nbsp;&nbsp;GU d- s++:&gt;++:+ a+ C++$ !U !P L++&gt;$ E-- W+(-) N- o?<br>
&nbsp;&nbsp;K? w !O !M V !PS PE- Y+ PGP+ t 5? X R* tv- b+ DI+++<br>
&nbsp;&nbsp;D-- G e++&gt; h--- !r x+++
    <br>
------END GEEK CODE BLOCK------<br>
    <br>
    <br>
-----Original Message-----<br>
From: linuxppc-embedded-bounces+claus.gindhart=<a
 href="mailto:kontron.com@ozlabs.org">kontron.com@ozlabs.org</a><br>
[mailto:<a
 href="mailto:linuxppc-embedded-bounces+claus.gindhart=kontron.com@ozlabs.org">
linuxppc-embedded-bounces+claus.gindhart=kontron.com@ozlabs.org</a>]<br>
On Behalf Of Frank D Lombardo<br>
Sent: Donnerstag, 24. August 2006 15:59<br>
To: <a href="mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org
    </a><br>
Subject: MontaVista 2.6 Kernel support for Xilinx ML40x<br>
    <br>
    <br>
I noticed that MontaVista now has their Pro 4.0 version (2.6 Kernel)<br>
available for the Xilinx ML40x series of boards.&nbsp;&nbsp;I would assume that<br>
means driver support for at least most of the hardware on the boards.
    <br>
Is this code that should be freely available?&nbsp;&nbsp;How would one get a copy<br>
of these drivers?&nbsp;&nbsp;I am interested in drivers for the ML403.<br>
    <br>
Thanks,<br>
Frank<br>
_______________________________________________<br>
Linuxppc-embedded mailing list
    <br>
    <a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>
    <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br>
_______________________________________________
    <br>
Linuxppc-embedded mailing list<br>
    <a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>
    <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded
    </a><br>
  </blockquote>
  </div>
  <br>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
</body>
</html>

--------------090305010208020506000003--
