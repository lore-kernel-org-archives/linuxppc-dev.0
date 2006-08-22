Return-Path: <dhlii@dlasys.net>
Received: from rwcrmhc15.comcast.net (rwcrmhc15.comcast.net [204.127.192.85])
	by ozlabs.org (Postfix) with ESMTP id 928D167C03
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 23 Aug 2006 07:05:20 +1000 (EST)
Message-ID: <44EB717D.3080800@dlasys.net>
Date: Tue, 22 Aug 2006 17:05:01 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: ioremap() fails for >64 MB
References: <1156232469.26041.19.camel@caxton.int.avalon.com.au>
	<44EAC56D.5020508@cambridgebroadband.com>
In-Reply-To: <44EAC56D.5020508@cambridgebroadband.com>
Content-Type: multipart/alternative;
	boundary="------------090607070307090309010109"
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
--------------090607070307090309010109
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

    is ioremap() failing or is vmalloc failing ?

    ioremap should just assign a virtual address to a physical address -
does it actually allocate anything ?
    I beleive I am ioremap()ing a greater than 64MB Flash ROM and I do
not think it is failing.

Alex Zeffertt wrote:
> Phil Nitschke wrote:
>   
>> Hi all,
>>
>> I have 2 GB memory on a 7448 processor, and want to reserve a huge chunk
>> of it at boot-time, then ioremap() it into the kernel space inside a
>> device driver.  So far I've succeeded with 64 MB, but can't go any
>> higher, as mm/vmalloc.c tells me: "allocation failed: out of vmalloc
>> space - use vmalloc=<size> to increase size."
>>
>>     
>
> I remember reading in Linux Device Drivers that you can use the bigphysarea
> patch to allocate large memory, as long as you do it at boot time.  It seems
> it's been ported to 2.6 too:
>
> 	http://lwn.net/Articles/111132/
>
> Alex
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------090607070307090309010109
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
&nbsp;&nbsp;&nbsp; is ioremap() failing or is vmalloc failing ?<br>
<br>
&nbsp;&nbsp;&nbsp; ioremap should just assign a virtual address to a physical address
- does it actually allocate anything ?<br>
&nbsp;&nbsp;&nbsp; I beleive I am ioremap()ing a greater than 64MB Flash ROM and I do
not think it is failing.<br>
<br>
Alex Zeffertt wrote:
<blockquote cite="mid44EAC56D.5020508@cambridgebroadband.com"
 type="cite">
  <pre wrap="">Phil Nitschke wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Hi all,

I have 2 GB memory on a 7448 processor, and want to reserve a huge chunk
of it at boot-time, then ioremap() it into the kernel space inside a
device driver.  So far I've succeeded with 64 MB, but can't go any
higher, as mm/vmalloc.c tells me: "allocation failed: out of vmalloc
space - use vmalloc=&lt;size&gt; to increase size."

    </pre>
  </blockquote>
  <pre wrap=""><!---->
I remember reading in Linux Device Drivers that you can use the bigphysarea
patch to allocate large memory, as long as you do it at boot time.  It seems
it's been ported to 2.6 too:

	<a class="moz-txt-link-freetext" href="http://lwn.net/Articles/111132/">http://lwn.net/Articles/111132/</a>

Alex
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>
  </pre>
</blockquote>
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

--------------090607070307090309010109--
