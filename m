Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BF54967C53
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Nov 2006 16:59:00 +1100 (EST)
Message-ID: <455AAB7F.9030905@dlasys.net>
Date: Wed, 15 Nov 2006 00:54:07 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Perl
References: <1163458589.5313.71.camel@mindpipe>
	<4559F7F9.4070008@grandegger.com>
	<1163528436.14674.22.camel@mindpipe>
In-Reply-To: <1163528436.14674.22.camel@mindpipe>
Content-Type: multipart/alternative;
	boundary="------------030101070204030608050806"
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
--------------030101070204030608050806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Lee Revell wrote:
> On Tue, 2006-11-14 at 18:08 +0100, Wolfgang Grandegger wrote:
>   
>> Lee Revell wrote:
>>     
>>> I've been trying to cross compile Perl for a PPC440 board and it just
>>> isn't happening.  Perl is probably the least amenable application to
>>> cross compiling I've found.
>>>
>>> I tried the instructions in the Cross/ directory of the Perl distro but
>>> they don't work - "sh Configure" fails on my target because it expects a
>>> full C development environment, which won't fit.
>>>
>>> Is there any easy solution?  Can someone send me a binary?
>>>       
>> Configure and make perl natively on your target platform. I have done it 
>> some time ago with the ELDK.
>>
>>     
>
> I've almost got the cross compile method described in INSTALL to work
> (using SSH to the target).  But it just hangs forever at "Checking how
> to flush all pending stdio output...".  Argh.
>
> Compiling natively on the target is not an option, the perl build
> process has too many dependencies.  It depends on stuff fron GNU
> coreutils like /bin/comm that is not available in busybox.
>
> Does no one out there have a binary they are willing to send me?
>
> Lee
>   
    You can also use something like a Mac PowerBook with ppc4xx 
crosstools as a build and test environment.
    I did most of my early link port work that way, though I now use 
crosstools under colinux.



>
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


--------------030101070204030608050806
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Lee Revell wrote:
<blockquote cite="mid:1163528436.14674.22.camel@mindpipe" type="cite">
  <pre wrap="">On Tue, 2006-11-14 at 18:08 +0100, Wolfgang Grandegger wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Lee Revell wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">I've been trying to cross compile Perl for a PPC440 board and it just
isn't happening.  Perl is probably the least amenable application to
cross compiling I've found.

I tried the instructions in the Cross/ directory of the Perl distro but
they don't work - "sh Configure" fails on my target because it expects a
full C development environment, which won't fit.

Is there any easy solution?  Can someone send me a binary?
      </pre>
    </blockquote>
    <pre wrap="">Configure and make perl natively on your target platform. I have done it 
some time ago with the ELDK.

    </pre>
  </blockquote>
  <pre wrap=""><!---->
I've almost got the cross compile method described in INSTALL to work
(using SSH to the target).  But it just hangs forever at "Checking how
to flush all pending stdio output...".  Argh.

Compiling natively on the target is not an option, the perl build
process has too many dependencies.  It depends on stuff fron GNU
coreutils like /bin/comm that is not available in busybox.

Does no one out there have a binary they are willing to send me?

Lee
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; You can also use something like a Mac PowerBook with ppc4xx
crosstools as a build and test environment.<br>
&nbsp;&nbsp;&nbsp; I did most of my early link port work that way, though I now use
crosstools under colinux.<br>
<br>
<br>
<br>
<blockquote cite="mid:1163528436.14674.22.camel@mindpipe" type="cite">
  <pre wrap="">

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

--------------030101070204030608050806--
