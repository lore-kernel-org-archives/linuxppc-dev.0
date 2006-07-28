Return-Path: <bennett78@digis.net>
Received: from mercury.testsyseng.com (unknown [209.120.144.205])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C9CD67A2E
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jul 2006 00:03:15 +1000 (EST)
Message-ID: <44CA1909.5080001@digis.net>
Date: Fri, 28 Jul 2006 08:02:49 -0600
From: bennett78 <bennett78@digis.net>
MIME-Version: 1.0
To: dhlii@comcast.net
Subject: Re: Booting Linux Kernel without bootloader
References: <3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local>
	<44C9C4E4.2060206@dlasys.net>
In-Reply-To: <44C9C4E4.2060206@dlasys.net>
Content-Type: multipart/alternative;
	boundary="------------070108020504090709010501"
Cc: Clint Thomas <cthomas@Soneticom.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Reply-To: bennett78@digis.net
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
--------------070108020504090709010501
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

David H. Lynch Jr. wrote:

> Clint Thomas wrote:
>
>> Hey guys,
>>
>> I have gone through the Linuxppc embedded and dev lists for 
>> information related to what I am trying to do, but was unable to find 
>> exactly what i'm looking for.
>>
>> Basically, the system I want linux running on does not require the 
>> initialization of hardware that U-boot provides, or at least it does 
>> not need it to boot the linux kernel. I want to load an uncompressed 
>> linux kernel into memory and start the execution of the kernel, 
>> without using any kind of bootloader. Is this possible? Or does linux 
>> need some kind of firmware or other software to tell it to start 
>> executing? Thanks for any info you might have.
>
>
>     You system powers on. It starts executing whatever is at the reset 
> vector, Something has to get you from the ppc powering up and going to 
> never never land, to starting to execute Linux.
>     The steps to get from Power on to booting Linux may not be that 
> complicated, Much of what needs to be done can likely be included as 
> part of the code for your board in arch/ppc/boot/simple.
>     But something still has to be done.
>
>     In my instance I am dealing with a Xilinx V4 (not an ML403). A 
> small "monitor" program is automatically loaded as part of the FPGA 
> .bit image. On power on it starts executing.

Curious, how long does the V4 take to load up it's brain? (using a 
serial EEprom?)

>     It sets up the CPU, cache, and very minimal hardware 
> configuration, and then loads Linux out of flash and executes it.
>    
>     Linux does not have to have alot setup to boot. But something has 
> to to some minimal initial setup, get Linux into the memory of your 
> system, and jump to it.
>
>>  
>> Clinton Thomas
>> cthomas@soneticom.com
>>  
>>
>>------------------------------------------------------------------------
>>
>>_______________________________________________
>>Linuxppc-embedded mailing list
>>Linuxppc-embedded@ozlabs.org
>>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>
>
>-- 
>Dave Lynch 					  	    DLA Systems
>Software Development:  				         Embedded Linux
>717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
>fax: 1.253.369.9244 			           Cell: 1.717.587.7774
>Over 25 years' experience in platforms, languages, and technologies too numerous to list.
>
>"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
>Albert Einstein
>  
>
>------------------------------------------------------------------------
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>

Frank Bennett

*/Technical Contractor/*

/Triad Systems Engineering
200 West Mountain Avenue, Suite 103C
Ft. Collins, CO 80521
/http://www.traidsyseng.com <http://www.triadsyseng.com>
frank.bennett@triadsyseng.com <mailto:frank.bennett@triadsyseng.com>/
/office: 970-493-7586
cell:   970-402-9269

"I think there's a world market for about five computers."
        -- attr. Thomas J. Watson (Chairman of the Board, IBM), 1943




--------------070108020504090709010501
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
David H. Lynch Jr. wrote:
<blockquote cite="mid44C9C4E4.2060206@dlasys.net" type="cite">
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
Clint Thomas wrote:
  <blockquote
 cite="mid3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local"
 type="cite">
    <meta http-equiv="Content-Type" content="text/html; ">
    <meta content="MSHTML 6.00.2900.2912" name="GENERATOR">
    <div><font face="Arial" size="2"><span class="675052722-25072006">Hey
guys,<br>
    <br>
I have gone through the Linuxppc embedded and dev lists for information
related to what I am trying to do, but was unable to find exactly what
i'm looking for.<br>
    <br>
Basically, the system I want linux running on does not require the
initialization of hardware that U-boot provides, or at least it does
not need it to boot the linux kernel. I want to load an uncompressed
linux kernel into memory and start the execution of the kernel, without
using any kind of bootloader. Is this possible? Or does linux need some
kind of firmware or other software to tell it to start executing?
Thanks for any info you might have.</span></font></div>
  </blockquote>
  <br>
&nbsp;&nbsp;&nbsp; You system powers on. It starts executing whatever is at the reset
vector, Something has to get you from the ppc powering up and going to
never never land, to starting to execute Linux.<br>
&nbsp;&nbsp;&nbsp; The steps to get from Power on to booting Linux may not be that
complicated, Much of what needs to be done can likely be included as
part of the code for your board in arch/ppc/boot/simple.<br>
&nbsp;&nbsp;&nbsp; But something still has to be done.<br>
  <br>
&nbsp;&nbsp;&nbsp; In my instance I am dealing with a Xilinx V4 (not an ML403). A
small "monitor" program is automatically loaded as part of the FPGA
.bit image. On power on it starts executing.<br>
</blockquote>
Curious, how long does the V4 take to load up it's brain? (using a
serial EEprom?)<br>
<blockquote cite="mid44C9C4E4.2060206@dlasys.net" type="cite">&nbsp;&nbsp;&nbsp; It
sets up the CPU, cache, and very minimal hardware configuration,
and then loads Linux out of flash and executes it.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; Linux does not have to have alot setup to boot. But something has
to to some minimal initial setup, get Linux into the memory of your
system, and jump to it.<br>
  <br>
  <blockquote
 cite="mid3C02138692C13C4BB675FE7EA240952915DF66@bluefin.Soneticom.local"
 type="cite">
    <div>&nbsp;</div>
    <div align="left"><font face="Arial" size="2">Clinton Thomas<br>
    <a class="moz-txt-link-abbreviated"
 href="mailto:cthomas@soneticom.com">cthomas@soneticom.com</a></font></div>
    <div>&nbsp;</div>
    <pre wrap=""><hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated"
 href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext"
 href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
  </blockquote>
  <br>
  <br>
  <pre class="moz-signature" cols="72">-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated"
 href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a
 class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
  </pre>
  <pre wrap="">
<hr size="4" width="90%">
_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></pre>
</blockquote>
<br>
<span style="font-style: italic; font-weight: bold;">Frank Bennett</span><br>
<div class="moz-signature">
<pre wrap=""><b><big><font face="Times New Roman, Times, serif"><em>Technical Contractor</em></font></big></b><span
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

"I think there's a world market for about five computers."
        -- attr. Thomas J. Watson (Chairman of the Board, IBM), 1943

<span style="text-decoration: underline;">
</span>
</pre>
</div>
</body>
</html>

--------------070108020504090709010501--
