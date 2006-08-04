Return-Path: <dhlii@dlasys.net>
Received: from sccrmhc14.comcast.net (sccrmhc14.comcast.net [63.240.77.84])
	by ozlabs.org (Postfix) with ESMTP id 72CAC679E2
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Aug 2006 01:35:36 +1000 (EST)
Message-ID: <44D36940.7050908@dlasys.net>
Date: Fri, 04 Aug 2006 11:35:28 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Peter Korsgaard <jacmet@sunsite.dk>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: XUPV2P, Kernel 2.6.17 boot problem
References: <20060801100220.26176938@bob.dt.e-technik.uni-dortmund.de>	<44D1021C.5080602@dlasys.net>
	<87irl8zjl7.fsf@sleipner.barco.com>
In-Reply-To: <87irl8zjl7.fsf@sleipner.barco.com>
Content-Type: multipart/alternative;
	boundary="------------040600050803010400000200"
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
--------------040600050803010400000200
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Peter Korsgaard wrote:
>>>>>> "DHL" == David H Lynch <dhlii@dlasys.net> writes:
>>>>>>             
>
>   
>>> Linux/PPC load: console=ttyS0,9600.....
>>>
>>> Uncompressing Linux...inflate returned FFFFFFFB exit
>>>
>>>       
>
> DHL>     Zlib was upgraded with 2.6.17. The updated Zlib is broken on
> DHL> ppc32.  I am pretty certain it is fixed in 2.6.18-rc3
>
> No, that was ony added in 2.6.18-rc1 (and the fix was only added
> post-rc3), so that can't be it..
>   
    I am not sure of the details, but I had the exact same problem, I
used "git bisect" to isolate it.
    and it bisected down to the Zlib patch I backed that out and I was
able to go from 2.6.16.21. all the way to 2.6.18-rc2.
    I beleive there is another problem of some kind that effects Xilinx
ppc's that went in and got fixed between 2.6.16.21 and 2.6.18-rcx.
    Though my symptoms were different for that one, and I was never able
to isolate it because even though I could not get 2.6.17 to work,
    The stuff in the 2.6 git tree did.
   
    Have you tried 2.6.18.x to see if your stuff works with it ?




-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein


--------------040600050803010400000200
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Peter Korsgaard wrote:
<blockquote cite="mid87irl8zjl7.fsf@sleipner.barco.com" type="cite">
  <blockquote type="cite">
    <blockquote type="cite">
      <blockquote type="cite">
        <blockquote type="cite">
          <blockquote type="cite">
            <pre wrap="">"DHL" == David H Lynch <a class="moz-txt-link-rfc2396E" href="mailto:dhlii@dlasys.net">&lt;dhlii@dlasys.net&gt;</a> writes:
            </pre>
          </blockquote>
        </blockquote>
      </blockquote>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
  </pre>
  <blockquote type="cite">
    <blockquote type="cite">
      <pre wrap="">Linux/PPC load: console=ttyS0,9600.....

Uncompressing Linux...inflate returned FFFFFFFB exit

      </pre>
    </blockquote>
  </blockquote>
  <pre wrap=""><!---->
DHL&gt;     Zlib was upgraded with 2.6.17. The updated Zlib is broken on
DHL&gt; ppc32.  I am pretty certain it is fixed in 2.6.18-rc3

No, that was ony added in 2.6.18-rc1 (and the fix was only added
post-rc3), so that can't be it..
  </pre>
</blockquote>
&nbsp;&nbsp;&nbsp; I am not sure of the details, but I had the exact same problem, I
used "git bisect" to isolate it.<br>
&nbsp;&nbsp;&nbsp; and it bisected down to the Zlib patch I backed that out and I was
able to go from 2.6.16.21. all the way to 2.6.18-rc2.<br>
&nbsp;&nbsp;&nbsp; I beleive there is another problem of some kind that effects Xilinx
ppc's that went in and got fixed between 2.6.16.21 and 2.6.18-rcx.<br>
&nbsp;&nbsp;&nbsp; Though my symptoms were different for that one, and I was never
able to isolate it because even though I could not get 2.6.17 to work,<br>
&nbsp;&nbsp;&nbsp; The stuff in the 2.6 git tree did.<br>
&nbsp;&nbsp;&nbsp; <br>
&nbsp;&nbsp;&nbsp; Have you tried 2.6.18.x to see if your stuff works with it ?<br>
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

--------------040600050803010400000200--
