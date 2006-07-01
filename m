Return-Path: <dhlii@dlasys.net>
Received: from rwcrmhc15.comcast.net (rwcrmhc15.comcast.net [204.127.192.85])
	by ozlabs.org (Postfix) with ESMTP id C561067A5F
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Jul 2006 16:21:39 +1000 (EST)
Message-ID: <44A61468.2020105@dlasys.net>
Date: Sat, 01 Jul 2006 02:21:28 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: Xilinx SystemACE driver for 2.6
References: <BAY110-F40223AFCCAA679FBC5A962B27D0@phx.gbl>
	<44A560D1.9050509@ru.mvista.com>
In-Reply-To: <44A560D1.9050509@ru.mvista.com>
Content-Type: multipart/alternative;
	boundary="------------030007050100060505050409"
Cc: linuxppc-embedded@ozlabs.org
Reply-To: dhlii@comcast.net
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
--------------030007050100060505050409
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Andrei Konovalov wrote:
>>
>> I use this version only because I want to implement the Temac driver in the 
>> link of 
>> http://ozlabs.org/pipermail/linuxppc-embedded/2006-March/022365.html It 
>> looks that the patches are specific for that version. 
>>     
>
> There is nothing special in the TEMAC driver that binds it to 2.6.16-rc5.
> The patch was generated against and tested with that kernel version. That's all.
> The patch will probably not apply cleanly to the more recent kernels. But
> otherwise it should work.
>
> In other words, feel free to use that TEMAC patch with the recent kernel.
>   
    I am trying to get a local link version of the hard TEMAC that is
part of the V4 FX FPGA working against a 2.6 Kernel. Would this be an
appropriate patch for that ?
    Is it even close ?

    There are so many different Xilinx (and other) TEMACs floating
around and so many permutation of those that my head is fogged in.

  





-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------030007050100060505050409
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Andrei Konovalov wrote:
<blockquote cite="mid44A560D1.9050509@ru.mvista.com" type="cite">
  <blockquote type="cite"><br>
    <pre wrap="">I use this version only because I want to implement the Temac driver in the 
link of 
<a class="moz-txt-link-freetext" href="http://ozlabs.org/pipermail/linuxppc-embedded/2006-March/022365.html">http://ozlabs.org/pipermail/linuxppc-embedded/2006-March/022365.html</a> It 
looks that the patches are specific for that version. 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
There is nothing special in the TEMAC driver that binds it to 2.6.16-rc5.
The patch was generated against and tested with that kernel version. That's all.
The patch will probably not apply cleanly to the more recent kernels. But
otherwise it should work.

In other words, feel free to use that TEMAC patch with the recent kernel.
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; I am trying to get a local link version of the hard TEMAC that is
part of the V4 FX FPGA working against a 2.6 Kernel. Would this be an
appropriate patch for that ?<br>
&nbsp;&nbsp;&nbsp; Is it even close ?<br>
<br>
&nbsp;&nbsp;&nbsp; There are so many different Xilinx (and other) TEMACs floating
around and so many permutation of those that my head is fogged in.<br>
<br>
&nbsp;&nbsp; <br>
<br>
<br>
<br>
<br>
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

--------------030007050100060505050409--
