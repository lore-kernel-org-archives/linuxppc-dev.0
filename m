Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id DF3CC2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Nov 2004 03:14:11 +1100 (EST)
Message-ID: <419CCC85.8080003@mrv.com>
Date: Thu, 18 Nov 2004 11:23:33 -0500
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <419CBB67.1070301@mrv.com>
	<20041118160946.GD12054@smtp.west.cox.net>
In-Reply-To: <20041118160946.GD12054@smtp.west.cox.net>
Content-Type: multipart/alternative;
	boundary="------------080106080700050705040501"
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: kernel 2.6.10-rc2 - Embedded MPC8xx - processor option gone !?
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
--------------080106080700050705040501
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Is anyone working on a fix already ?
Will the MPC8xx support be functionnal for 2.6.10 ?

Thanks.
Guillaume.

Tom Rini wrote:

>On Thu, Nov 18, 2004 at 10:10:31AM -0500, Guillaume Autran wrote:
>
>  
>
>>Does anyone know why the option "8xx" in the "Processor Type" screen of 
>>the menuconfig is gone ?
>>    
>>
>
>It's not gone, it just depends on CONFIG_BROKEN.  A lot of code was
>finally synced up, but since it's not fully functional (it's the same
>state as was in linuxppc-2.5), it requires CONFIG_BROKEN to be set.
>
>  
>

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 


--------------080106080700050705040501
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Is anyone working on a fix already ? <br>
Will the MPC8xx support be functionnal for 2.6.10 ?<br>
<br>
Thanks.<br>
Guillaume.<br>
<br>
Tom Rini wrote:<br>
<blockquote type="cite"
 cite="mid20041118160946.GD12054@smtp.west.cox.net">
  <pre wrap="">On Thu, Nov 18, 2004 at 10:10:31AM -0500, Guillaume Autran wrote:

  </pre>
  <blockquote type="cite">
    <pre wrap="">Does anyone know why the option "8xx" in the "Processor Type" screen of 
the menuconfig is gone ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It's not gone, it just depends on CONFIG_BROKEN.  A lot of code was
finally synced up, but since it's not fully functional (it's the same
state as was in linuxppc-2.5), it requires CONFIG_BROKEN to be set.

  </pre>
</blockquote>
<br>
<pre class="moz-signature" cols="72">-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: <a class="moz-txt-link-abbreviated" href="mailto:gautran@mrv.com">gautran@mrv.com</a>
======================================= </pre>
</body>
</html>

--------------080106080700050705040501--
