Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id D60D867A7F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 08:45:09 +1100 (EST)
Message-ID: <423F4071.1000001@mrv.com>
Date: Mon, 21 Mar 2005 16:45:21 -0500
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>	<20050210150437.GA19134@logos.cnet>	<c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>	<20050210170658.GA20153@logos.cnet>
	<20050210170859.GB20153@logos.cnet>
In-Reply-To: <20050210170859.GB20153@logos.cnet>
Content-Type: multipart/alternative;
	boundary="------------000805080702080102080705"
Cc: "Smith, Craig" <craig.d.smith@siemens.com>
Subject: Re: Linux 2.6.x on 8xx status
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
--------------000805080702080102080705
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Was there any progress made about this issue or is it still pending ? 
I'm running 2.6.11 and still see the problem...

Regards,
Guillaume.



Marcelo Tosatti wrote:

>On Thu, Feb 10, 2005 at 03:06:58PM -0200, Marcelo Tosatti wrote:
>  
>
>>On Thu, Feb 10, 2005 at 02:26:52PM -0500, Dan Malek wrote:
>>    
>>
>>>On Feb 10, 2005, at 10:04 AM, Marcelo Tosatti wrote:
>>>
>>>      
>>>
>>>>Does anyone have a clue of what is/can be wrong with the TLB entry for 
>>>>the
>>>>address being flushed at __flush_dcache_icache()?
>>>>        
>>>>
>>>Not sure.  The problem is that the __flush_dcache_icache is passed a
>>>user space virtual address that doesn't look like it is mapped for 
>>>writing
>>>or something.  I don't know, as an ooops isn't sufficient to debug the 
>>>problem.
>>>You have to catch it here and track down the current state of the TLB 
>>>and
>>>the page tables.  Of course, when I do this everything looks OK, 
>>>      
>>>
>>How do you do track down the current TLB state? With a BDI? 
>>
>>    
>>
>>>so what I've been trying to do is catch the TLBmiss reload that actually causes 
>>>this
>>>to happen to see what it really tried to load into the tlb.
>>>      
>>>
>>Shouldnt it be loading the TLB entry which "seem to be OK" accordingly to your
>>analysis ?? 
>>    
>>
>
>So this assumption which you have made sometime ago is wrong, given that now you 
>know TLB entry is not stale ?
>
>"The symptom is we appear to have a stale TLB entry,
>so at least one of the callouts from the generic VM
>code isn't doing the right thing for us.  I'm still
>puzzled as to why it doesn't affect other PPC processor." 
>
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
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


--------------000805080702080102080705
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Hi,<br>
<br>
Was there any progress made about this issue or is it still pending ?
I'm running 2.6.11 and still see the problem...<br>
<br>
Regards,<br>
Guillaume.<br>
<br>
<br>
<br>
Marcelo Tosatti wrote:<br>
<blockquote type="cite" cite="mid20050210170859.GB20153@logos.cnet">
  <pre wrap="">On Thu, Feb 10, 2005 at 03:06:58PM -0200, Marcelo Tosatti wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">On Thu, Feb 10, 2005 at 02:26:52PM -0500, Dan Malek wrote:
    </pre>
    <blockquote type="cite">
      <pre wrap="">On Feb 10, 2005, at 10:04 AM, Marcelo Tosatti wrote:

      </pre>
      <blockquote type="cite">
        <pre wrap="">Does anyone have a clue of what is/can be wrong with the TLB entry for 
the
address being flushed at __flush_dcache_icache()?
        </pre>
      </blockquote>
      <pre wrap="">Not sure.  The problem is that the __flush_dcache_icache is passed a
user space virtual address that doesn't look like it is mapped for 
writing
or something.  I don't know, as an ooops isn't sufficient to debug the 
problem.
You have to catch it here and track down the current state of the TLB 
and
the page tables.  Of course, when I do this everything looks OK, 
      </pre>
    </blockquote>
    <pre wrap="">How do you do track down the current TLB state? With a BDI? 

    </pre>
    <blockquote type="cite">
      <pre wrap="">so what I've been trying to do is catch the TLBmiss reload that actually causes 
this
to happen to see what it really tried to load into the tlb.
      </pre>
    </blockquote>
    <pre wrap="">Shouldnt it be loading the TLB entry which "seem to be OK" accordingly to your
analysis ?? 
    </pre>
  </blockquote>
  <pre wrap=""><!---->
So this assumption which you have made sometime ago is wrong, given that now you 
know TLB entry is not stale ?

"The symptom is we appear to have a stale TLB entry,
so at least one of the callouts from the generic VM
code isn't doing the right thing for us.  I'm still
puzzled as to why it doesn't affect other PPC processor." 

_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>

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

--------------000805080702080102080705--
