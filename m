Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6EDD067C5F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Oct 2006 16:36:28 +1000 (EST)
Message-ID: <4542CFE5.3070105@dlasys.net>
Date: Fri, 27 Oct 2006 23:35:01 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Pradeep Sampath <pradeepsampath@yahoo.com>
Subject: Re: TEMAC drivers for kernel 2.6.17.1
References: <20061027192025.26161.qmail@web83212.mail.mud.yahoo.com>
In-Reply-To: <20061027192025.26161.qmail@web83212.mail.mud.yahoo.com>
Content-Type: multipart/alternative;
	boundary="------------040300010300090109090503"
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
--------------040300010300090109090503
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Pradeep Sampath wrote:
> Hi,
>  
> I am using linux kernel 2.6.17.1 on ML403 dev board. I am trying to 
> get the TEMAC to work but with no success. I applied TEMAC patches 
> from http://source.mvista.com/~ank/paulus-powerpc/20060309/ 
> <http://source.mvista.com/%7Eank/paulus-powerpc/20060309/>. But the 
> ethernet interface does not seem to come up. 
> Is there any other TEMAC patch out there which is known to work with 
> 2.6 kernel? 
>  
> For the BSP I tried using the ML403 EDK Embedded PowerPC reference 
> design from Xilinx. But it doesn't come with a PLB TEMAC in the 
> design. I also tried to use xapp902 which has the PLB TEMAC module. 
> But on running "Generate Libraries and BSPs" it does not generate any 
> sources code under "drivers" or "arch" folder.
I do nto beleive Xilinx has released an EDK that includes Linux 2.6 support.
The patches you linked to should work for a 2.6 kernel with a PLB TEMAC. 
But you must manually go in and force the speed to whatever you need. 
The MV driver at your link does nto autonegotiate.

I have a combined LL_TEMAC/PLB_TEMAC driver that does autonegotiate. It 
did work for the LL_TEMAC several iterations ago, but  I have not tested 
it in some time.
It does not yet  work for Linux. It is very loosely based on the MV 
driver, but does nt use the EDK, and is only for the LL_TEMAC and FIFO 
PLB_TEMAC.

There is a link to it in a previous message.

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------040300010300090109090503
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Pradeep Sampath wrote:
<blockquote
 cite="mid:20061027192025.26161.qmail@web83212.mail.mud.yahoo.com"
 type="cite">
  <div>Hi,</div>
  <div>&nbsp;</div>
  <div>I am using linux kernel 2.6.17.1 on ML403 dev board. I am trying
to get the TEMAC to work but with no success. I applied&nbsp;TEMAC patches
from <a moz-do-not-send="true"
 href="http://source.mvista.com/%7Eank/paulus-powerpc/20060309/"
 target="_blank" rel="nofollow" _=""><font color="#003399">http://source.mvista.com/~ank/paulus-powerpc/20060309/</font></a>.
But the ethernet interface does not seem to come up.&nbsp;<br>
  </div>
  <div>Is there any other TEMAC patch out there which is known to work
with 2.6 kernel?&nbsp;</div>
  <div>&nbsp;</div>
  <div>For the BSP I tried using the ML403 EDK Embedded PowerPC
reference design from Xilinx. But it doesn't come with a PLB TEMAC in
the design. I also tried to use xapp902 which has the PLB TEMAC module.
But on running "Generate Libraries and BSPs" it does not generate any
sources code under "drivers" or "arch" folder.</div>
</blockquote>
I do nto beleive Xilinx has released an EDK that includes Linux 2.6
support.<br>
The patches you linked to should work for a 2.6 kernel with a PLB
TEMAC. But you must manually go in and force the speed to whatever you
need. The MV driver at your link does nto autonegotiate.<br>
<br>
I have a combined LL_TEMAC/PLB_TEMAC driver that does autonegotiate. It
did work for the LL_TEMAC several iterations ago, but&nbsp; I have not
tested it in some time.<br>
It does not yet&nbsp; work for Linux. It is very loosely based on the MV
driver, but does nt use the EDK, and is only for the LL_TEMAC and FIFO
PLB_TEMAC.<br>
<br>
There is a link to it in a previous message.<br>
<br>
<pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated" href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
</pre>
</body>
</html>

--------------040300010300090109090503--
