Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6224F689C0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 21 Jan 2006 07:41:11 +1100 (EST)
Message-ID: <43D14ACE.8090204@digis.net>
Date: Fri, 20 Jan 2006 13:40:46 -0700
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: u-boot debugging
References: <20060120194815.654AD353A3F@atlas.denx.de>
In-Reply-To: <20060120194815.654AD353A3F@atlas.denx.de>
Content-Type: multipart/alternative;
	boundary="------------040604050307060904020207"
Cc: atul.sabharwal@exgate.tek.com, linuxppc-embedded@ozlabs.org
Reply-To: Frank Bennett <bennett78@digis.net>
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
--------------040604050307060904020207
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Wolfgang Denk wrote:

>In message <4A062D477D842B4C8FC48EA5AF2D41F201AC2CC8@us-bv-m23.global.tektronix.net> you wrote:
>  
>
>>Besides, the BDI has only a 10Mbps Ethernet interface.  It might be
>>enough for simple debug operation but they should
>>Have put a 100Mbps link to put it on a shared network.  For an isolated
>>network configuration, it should suffice...
>>    
>>
>
>  
>
Yeah this thread is covering a broad range of JTAG debug. There
are debuggers that range form $50 to $50k with no JTAG standard. 
$50 wigglers that are painfully slow because they bit-bang the parallel
port and $50k Gigabit interface with GBs of fast memory that can "capture
bugs" in realtime (that is if you can define/setup the trigger condition to
capture "the bug", but for a 400MHz processor that may only mean 1-2
seconds of data).  The BDI is a nice product for $2k, wish I would of
thought of designing it. You can either communicate with it directly for
single step, breakpointing, etc, but the coolness is the capability to run
remote gdb, then there is insight which is a gui that runs ontop of gdb....
works great debugging u-boot and kernel/user code later....but the best
part is no need for windose and with DENX you don't have to pay big
$ to metrowerks, greenhills or the like and wait while they develop or
if they will ever develop debugger software for your target!

>You should really get a clue. Or can you please explain what  is  the
>maximum  transfer rate you can get over the BDM / JTAG interface, and
>how is this limited by the 10Mbps Ethernet interface?
>
>
>Best regards,
>
>Wolfgang Denk
>
>  
>


-- 

*/Frank Bennett
Technical Contractor/*

/Triad Systems Engineering
200 West Mountain Avenue, Suite 103C
Ft. Collins, CO 80521
/http://www.traidsyseng.com <http://www.triadsyseng.com>
frank.bennett@triadsyseng.com <mailto:frank.bennett@triadsyseng.com>/
/office: 970-493-7586
cell:   970-402-9269



--------------040604050307060904020207
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Wolfgang Denk wrote:
<blockquote cite="mid20060120194815.654AD353A3F@atlas.denx.de"
 type="cite">
  <pre wrap="">In message <a class="moz-txt-link-rfc2396E" href="mailto:4A062D477D842B4C8FC48EA5AF2D41F201AC2CC8@us-bv-m23.global.tektronix.net">&lt;4A062D477D842B4C8FC48EA5AF2D41F201AC2CC8@us-bv-m23.global.tektronix.net&gt;</a> you wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Besides, the BDI has only a 10Mbps Ethernet interface.  It might be
enough for simple debug operation but they should
Have put a 100Mbps link to put it on a shared network.  For an isolated
network configuration, it should suffice...
    </pre>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
</blockquote>
Yeah this thread is covering a broad range of JTAG debug. There<br>
are debuggers that range form $50 to $50k with no JTAG standard.&nbsp; <br>
$50 wigglers that are painfully slow because they bit-bang the parallel
<br>
port and $50k Gigabit interface with GBs of fast memory that can
"capture <br>
bugs" in realtime (that is if you can define/setup the trigger
condition to <br>
capture "the bug", but for a 400MHz processor that may only mean 1-2 <br>
seconds of data).&nbsp; The BDI is a nice product for $2k, wish I would of <br>
thought of designing it. You can either communicate with it directly
for <br>
single step, breakpointing, etc, but the coolness is the capability to
run <br>
remote gdb, then there is insight which is a gui that runs ontop of
gdb....<br>
works great debugging u-boot and kernel/user code later....but the best
<br>
part is no need for windose and with DENX you don't have to pay big <br>
$ to metrowerks, greenhills or the like and wait while they develop or <br>
if they will ever develop debugger software for your target!<br>
<blockquote cite="mid20060120194815.654AD353A3F@atlas.denx.de"
 type="cite">
  <pre wrap="">You should really get a clue. Or can you please explain what  is  the
maximum  transfer rate you can get over the BDM / JTAG interface, and
how is this limited by the 10Mbps Ethernet interface?


Best regards,

Wolfgang Denk

  </pre>
</blockquote>
<br>
<br>
<div class="moz-signature">-- <br>
<meta content="text/html;" http-equiv="Content-Type">
<title></title>
<pre wrap=""><b><big><font face="Times New Roman, Times, serif"><em>Frank Bennett
Technical Contractor</em></font></big></b><span
 style="text-decoration: underline;">
</span>
<i><font face="Helvetica, Arial, sans-serif">Triad Systems Engineering
200 West Mountain Avenue, Suite 103C
Ft. Collins, CO 80521
</font></i><a href="http://www.triadsyseng.com">http://www.traidsyseng.com</a>
<span style="text-decoration: underline;"><a
 href="mailto:frank.bennett@triadsyseng.com">frank.bennett@triadsyseng.com</a></span><i><font
 face="Helvetica, Arial, sans-serif">
</font></i>office: 970-493-7586
cell:&nbsp;&nbsp; 970-402-9269
<span style="text-decoration: underline;">
</span>
</pre>
</div>
</body>
</html>

--------------040604050307060904020207--
