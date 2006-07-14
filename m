Return-Path: <dhlii@dlasys.net>
Received: from rwcrmhc13.comcast.net (rwcrmhc13.comcast.net [204.127.192.83])
	by ozlabs.org (Postfix) with ESMTP id C0CC767B72
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jul 2006 03:05:11 +1000 (EST)
Message-ID: <44B7CEB6.6040806@dlasys.net>
Date: Fri, 14 Jul 2006 13:04:54 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: bennett78@digis.net,
 linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: JTAG PPC info ?
References: <1152782030.3534.27.camel@petra.pixel>
	<44B6DD86.5080804@dlasys.net>
	<1152888198.44b7ad86a50ed@webmail.digis.net>
In-Reply-To: <1152888198.44b7ad86a50ed@webmail.digis.net>
Content-Type: multipart/alternative;
	boundary="------------050307030006030800090408"
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
--------------050307030006030800090408
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

bennett78@digis.net wrote:
> Quoting "David H. Lynch Jr." <dhlii@dlasys.net>:
>
>   
>>     Has anyone not covered by non-disclosure deciphered the JTAG codes
>> for the PowerPC ?
>>     
>
> Is this a big secret or just skimpy Freescale documentation?
> Try emailing:
>      Ed.Nuckolls@freescale.com
> This effort could help expand projects such as:
>       http://sourceforge.net/projects/jtager/
> for us embedded powerpc users!
>
> For myself, right now I can't get much help from Abatron turning
> on a new MPC5200 design. My approach: debugging modified u-boot code 
> running out of RAM....lots of machine checks!
>   

    It is my understanding that certain aspects of JTAG are specific to
the target (chip) for most devices that information is documented.
    Some processors treat the JTAG communications to the processor as
proprietary.
     Some make the information readily available.

    It is my understanding that the interface to the PPC is only
available under NDA from IBM.

    My client is building a wholely OpenSource SDK to support developing
for their target.
    They have their own pseudo JTAG interface - on the host side it
emulates a JTAG Parallel port in software.
    On the target side it is a full hardware JTAG.
    They are trying to get a gdbserver working and there is no
OpenSource GdbServer that includes PPC support.

    Right now they have a back burner project decyphering the the PPC
interface and are working through it slowly.


> Frank Bennett
> President
> Mathegraphics,LLC
> Fort Collins,CO 
> www.mathegraphics.com
> bennett78@digis.net
>
>
>   
>>    
>>     I have a situation using a custom JTAG interface that is looking to
>> impliment host side PPC debugging. JTAG access and manipulation of most
>> all other JTAG devices on the target is working.
>>     Right now the problem is deciphering the JTAG commands etc to the
>> PPC itself.
>>
>>
>>
>> Ria Roy wrote:
>>     
>>> Hi, 
>>>
>>> Does anyone know if Macriagor's mpDemon is capable of debugging the
>>> linux kernel via the JTAG interface. 
>>>
>>> Thanks in advance, 
>>> Ria
>>>
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>   
>>>       
>> -- 
>> Dave Lynch 					  	    DLA Systems
>> Software Development:  				         Embedded Linux
>> 717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
>> fax: 1.253.369.9244 			           Cell: 1.717.587.7774
>> Over 25 years' experience in platforms, languages, and technologies too
>> numerous to list.
>>
>> "Any intelligent fool can make things bigger and more complex... It takes a
>> touch of genius - and a lot of courage to move in the opposite direction."
>> Albert Einstein
>>
>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>
>>     
>
>
>
>
> -------------------------------------------------------
> Email sent through Digis Networks http://www.digis.net/
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------050307030006030800090408
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
<a class="moz-txt-link-abbreviated" href="mailto:bennett78@digis.net">bennett78@digis.net</a> wrote:
<blockquote cite="mid1152888198.44b7ad86a50ed@webmail.digis.net"
 type="cite">
  <pre wrap="">Quoting "David H. Lynch Jr." <a class="moz-txt-link-rfc2396E" href="mailto:dhlii@dlasys.net">&lt;dhlii@dlasys.net&gt;</a>:

  </pre>
  <blockquote type="cite">
    <pre wrap="">    Has anyone not covered by non-disclosure deciphered the JTAG codes
for the PowerPC ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Is this a big secret or just skimpy Freescale documentation?
Try emailing:
     <a class="moz-txt-link-abbreviated" href="mailto:Ed.Nuckolls@freescale.com">Ed.Nuckolls@freescale.com</a>
This effort could help expand projects such as:
      <a class="moz-txt-link-freetext" href="http://sourceforge.net/projects/jtager/">http://sourceforge.net/projects/jtager/</a>
for us embedded powerpc users!

For myself, right now I can't get much help from Abatron turning
on a new MPC5200 design. My approach: debugging modified u-boot code 
running out of RAM....lots of machine checks!
  </pre>
</blockquote>
<br>
&nbsp;&nbsp;&nbsp; It is my understanding that certain aspects of JTAG are specific to
the target (chip) for most devices that information is documented. <br>
&nbsp;&nbsp;&nbsp; Some processors treat the JTAG communications to the processor as
proprietary.<br>
&nbsp;&nbsp;&nbsp;&nbsp; Some make the information readily available.<br>
<br>
&nbsp;&nbsp;&nbsp; It is my understanding that the interface to the PPC is only
available under NDA from IBM.<br>
<br>
&nbsp;&nbsp;&nbsp; My client is building a wholely OpenSource SDK to support
developing for their target.<br>
&nbsp;&nbsp;&nbsp; They have their own pseudo JTAG interface - on the host side it
emulates a JTAG Parallel port in software. <br>
&nbsp;&nbsp;&nbsp; On the target side it is a full hardware JTAG.<br>
&nbsp;&nbsp;&nbsp; They are trying to get a gdbserver working and there is no
OpenSource GdbServer that includes PPC support.<br>
<br>
&nbsp;&nbsp;&nbsp; Right now they have a back burner project decyphering the the PPC
interface and are working through it slowly.<br>
<br>
<br>
<blockquote cite="mid1152888198.44b7ad86a50ed@webmail.digis.net"
 type="cite">
  <pre wrap="">
Frank Bennett
President
Mathegraphics,LLC
Fort Collins,CO 
<a class="moz-txt-link-abbreviated" href="http://www.mathegraphics.com">www.mathegraphics.com</a>
<a class="moz-txt-link-abbreviated" href="mailto:bennett78@digis.net">bennett78@digis.net</a>


  </pre>
  <blockquote type="cite">
    <pre wrap="">   
    I have a situation using a custom JTAG interface that is looking to
impliment host side PPC debugging. JTAG access and manipulation of most
all other JTAG devices on the target is working.
    Right now the problem is deciphering the JTAG commands etc to the
PPC itself.



Ria Roy wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">Hi, 

Does anyone know if Macriagor's mpDemon is capable of debugging the
linux kernel via the JTAG interface. 

Thanks in advance, 
Ria

_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>
  
      </pre>
    </blockquote>
    <pre wrap="">
-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       <a class="moz-txt-link-abbreviated" href="mailto:dhlii@dlasys.net">dhlii@dlasys.net</a> 	  <a class="moz-txt-link-freetext" href="http://www.dlasys.net">http://www.dlasys.net</a>
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too
numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a
touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein

_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

    </pre>
  </blockquote>
  <pre wrap=""><!---->



-------------------------------------------------------
Email sent through Digis Networks <a class="moz-txt-link-freetext" href="http://www.digis.net/">http://www.digis.net/</a>

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

--------------050307030006030800090408--
