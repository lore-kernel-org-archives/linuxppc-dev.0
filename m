Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 525F5688A2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 08:23:19 +1100 (EST)
Message-ID: <439752BE.9030207@digis.net>
Date: Wed, 07 Dec 2005 14:23:10 -0700
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <20051205203515.51D4C353F5E@atlas.denx.de>
In-Reply-To: <20051205203515.51D4C353F5E@atlas.denx.de>
Content-Type: multipart/alternative;
	boundary="------------050004020205030701090304"
Subject: Re: Video Card to Lite5200
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
--------------050004020205030701090304
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Wolfgang Denk wrote:

>Dear Alan,
>
>in message <dc70db7d0512051130s498f7d5fk42a0f4886c006efd@mail.gmail.com> you wrote:
>  
>
>>I am just looking for a cheaper video card to use with Lite5200 board.
>>CoralP is very expansive, then I will use ATI Rage Mobility.
>>    
>>
>
>Make sure that you don't need to run any (x86) BIOS code on your card
>to initialize it. This is the main issue with most graphics cards.
>
>  
>
>>Well, my video card is not ATI Rage Mobility M1 EVA, it has not 723
>>regulator, it use MTD3302 as regulator, do you know if I need change
>>something on the Lite5200's PCI slot to it work with this video card?
>>    
>>
>
>If your card is a true 3.3V PCI card it should be at  least  possible
>to  attach  and  test it. Chances are that it does not work (at least
>not without some amount of work).
>
>  
>
>>My Lite5200 is Version 2.0, and Freescale connected some wire (small cables)
>>to PCI slot, maybe to fix some PCI problems.
>>    
>>
>
>You probably want to ask FS about this.
>
>  
>
>>I am using linux kernel 2.6.14, downloaded from denx's web site. Linux is
>>    
>>
>
>Note that the 5200 code in the kernel is work in progress. I  do  not
>cleaim  that it does work in any way. If you want stable code use our
>2.4.25 kernel instead.
>
>  
>
>>running fine in this board, but until now I am using only serial console.
>>Now I want use a video card with it.
>>    
>>
>
>Well, if your time is worth anything you  might  find  out  that  the
>CoralP  is the cheaper solution - or using a graphics controller that
>can be attached directly to the bus.
>  
>
Wolfgang:
The denx.de web site looks great.

Where can someone get this PCI card?  Do I have to contact Fujitsu 
directly? Cost?
The Fujitsu CoralP evaluation board MB86295EB01? or did you use the 
Coral PA?
I saw a posting that you also had some streaming video running.  Tell me 
more.
What resolution? 4CIF (full DVD)
What display?  LCD SVGA (800x600) and/or VGA analog port?
Software MPEG decoder or does the Coral  have a decoder?
Which player did you use?
Is all this covered in some release notes?
Was the katix stuff ever integrated into linux_2_4_development?
How does Wolfgang make a living if he spends all his time answering our 
questions?

thanks,
Frank Bennett

>Best regards,
>
>Wolfgang Denk
>  
>
*//* <mailto:frank.bennett@triadsyseng.com>


--------------050004020205030701090304
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
<blockquote cite="mid20051205203515.51D4C353F5E@atlas.denx.de"
 type="cite">
  <pre wrap="">Dear Alan,

in message <a class="moz-txt-link-rfc2396E" href="mailto:dc70db7d0512051130s498f7d5fk42a0f4886c006efd@mail.gmail.com">&lt;dc70db7d0512051130s498f7d5fk42a0f4886c006efd@mail.gmail.com&gt;</a> you wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I am just looking for a cheaper video card to use with Lite5200 board.
CoralP is very expansive, then I will use ATI Rage Mobility.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Make sure that you don't need to run any (x86) BIOS code on your card
to initialize it. This is the main issue with most graphics cards.

  </pre>
  <blockquote type="cite">
    <pre wrap="">Well, my video card is not ATI Rage Mobility M1 EVA, it has not 723
regulator, it use MTD3302 as regulator, do you know if I need change
something on the Lite5200's PCI slot to it work with this video card?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
If your card is a true 3.3V PCI card it should be at  least  possible
to  attach  and  test it. Chances are that it does not work (at least
not without some amount of work).

  </pre>
  <blockquote type="cite">
    <pre wrap="">My Lite5200 is Version 2.0, and Freescale connected some wire (small cables)
to PCI slot, maybe to fix some PCI problems.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
You probably want to ask FS about this.

  </pre>
  <blockquote type="cite">
    <pre wrap="">I am using linux kernel 2.6.14, downloaded from denx's web site. Linux is
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Note that the 5200 code in the kernel is work in progress. I  do  not
cleaim  that it does work in any way. If you want stable code use our
2.4.25 kernel instead.

  </pre>
  <blockquote type="cite">
    <pre wrap="">running fine in this board, but until now I am using only serial console.
Now I want use a video card with it.
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Well, if your time is worth anything you  might  find  out  that  the
CoralP  is the cheaper solution - or using a graphics controller that
can be attached directly to the bus.
  </pre>
</blockquote>
Wolfgang:<br>
The denx.de web site looks great.<br>
<br>
Where can someone get this PCI card?&nbsp; Do I have to contact Fujitsu
directly? Cost?<br>
<span class="Standard">The Fujitsu CoralP evaluation board MB86295EB01?
or did you use the Coral PA?<br>
I saw a posting that you also had some streaming video running.&nbsp; Tell
me more.<br>
What resolution? 4CIF (full DVD) <br>
What display?&nbsp; LCD SVGA (800x600) and/or VGA analog port?<br>
Software MPEG decoder or does the Coral&nbsp; have a decoder?<br>
Which player did you use?<br>
Is all this covered in some release notes?<br>
Was the katix stuff ever integrated into linux_2_4_development?<br>
How does Wolfgang make a living if he spends all his time answering our
questions?<br>
<br>
thanks,<br>
Frank Bennett<br>
</span>
<blockquote cite="mid20051205203515.51D4C353F5E@atlas.denx.de"
 type="cite">
  <pre wrap="">
Best regards,

Wolfgang Denk
  </pre>
</blockquote>
<div class="moz-signature">
<pre wrap=""><b><big><font face="Times New Roman, Times, serif"><em></em></font></big></b><span
 style="text-decoration: underline;"><a
 href="mailto:frank.bennett@triadsyseng.com"></a></span><span
 style="text-decoration: underline;">
</span>
</pre>
</div>
</body>
</html>

--------------050004020205030701090304--
