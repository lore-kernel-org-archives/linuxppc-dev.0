Return-Path: <bennett78@lpbroadband.net>
Received: from omta09.mta.everyone.net (sitemail2.everyone.net
	[216.200.145.36]) by ozlabs.org (Postfix) with ESMTP id C3643DDE3F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Jan 2008 06:57:16 +1100 (EST)
Message-ID: <4794F19A.30604@lpbroadband.net>
Date: Mon, 21 Jan 2008 12:25:14 -0700
From: Frank Bennett <bennett78@lpbroadband.net>
MIME-Version: 1.0
To: "Benedict, Michael" <MBenedict@twacs.com>
Subject: Re: Early driver development resources
References: <BAF8B1E0BB28024A90895E746A3B610D1C2F01@twx-exch01.twacs.local>
In-Reply-To: <BAF8B1E0BB28024A90895E746A3B610D1C2F01@twx-exch01.twacs.local>
Content-Type: multipart/alternative;
	boundary="------------020107060008070705040403"
Cc: linuxppc-embedded@ozlabs.org
Reply-To: bennett78@lpbroadband.net
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
--------------020107060008070705040403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benedict, Michael wrote:
> Hello,
> 	I wrote a driver for a 4 segment digital display device.  I have
> a requirement that this device be used as early as possible to report
> kernel bootup state.  The driver itself is pretty simple, just using
> in/out_be32() and udelay().  The problem is that I don't know how to use
> hardware resources in the early stages of booting, before I can call
> request_mem_region() and friends.
> 	Can anyone recommend a book / documentation / reference code /
> anything that demonstrates this, or at least could improve my
> understanding enough to accomplish this?
>   
u-boot for embedded (or OpenBios) documentation, source code. 
Look for splash screen code although you will want to make
multiple calls for various boot states.   In the ISA days and now
PCI there are cards that display a two hex-digit POST progress
code which is a single x86, 8bit output instruction to port 0x80.
This may still be supported in closed source BIOS distributions.
Not sure what they do now with PCIe since it will take more than
a single, simple processor instruction.

-Frank Bennett
> 	Many thanks,
> 		Michael
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 

*/Frank Bennett
President/*

Mathegraphics,LLC
613 Bentley Pl
Fort Collins,CO 80526
970-229-9269 (hm) 970-402-9269 (cell)
www.mathegraphics.com <http://www.mathegraphics.com>
bennett78@lpbroadband.net <mailto:bennett78@lpbroadband.net>

"I think there's a world market for about five computers."  
-- attr. Thomas J. Watson (Chairman of the Board, IBM), 1943  


--------------020107060008070705040403
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Benedict, Michael wrote:
<blockquote
 cite="mid:BAF8B1E0BB28024A90895E746A3B610D1C2F01@twx-exch01.twacs.local"
 type="cite">
  <pre wrap="">Hello,
	I wrote a driver for a 4 segment digital display device.  I have
a requirement that this device be used as early as possible to report
kernel bootup state.  The driver itself is pretty simple, just using
in/out_be32() and udelay().  The problem is that I don't know how to use
hardware resources in the early stages of booting, before I can call
request_mem_region() and friends.
	Can anyone recommend a book / documentation / reference code /
anything that demonstrates this, or at least could improve my
understanding enough to accomplish this?
  </pre>
</blockquote>
u-boot for embedded (or OpenBios) documentation, source code.&nbsp; <br>
Look for splash screen code although you will want to make <br>
multiple calls for various boot states.&nbsp;&nbsp; In the ISA days and now<br>
PCI there are cards that display a two hex-digit POST progress <br>
code which is a single x86, 8bit output instruction to port 0x80.<br>
This may still be supported in closed source BIOS distributions.<br>
Not sure what they do now with PCIe since it will take more than<br>
a single, simple processor instruction.<br>
<br>
-Frank Bennett
<blockquote
 cite="mid:BAF8B1E0BB28024A90895E746A3B610D1C2F01@twx-exch01.twacs.local"
 type="cite">
  <pre wrap="">	Many thanks,
		Michael

_______________________________________________
Linuxppc-embedded mailing list
<a class="moz-txt-link-abbreviated" href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a>
<a class="moz-txt-link-freetext" href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a>
  </pre>
</blockquote>
<br>
<br>
<div class="moz-signature">-- <br>
<meta content="text/html; " http-equiv="content-type">
<title>sig</title>
<pre wrap=""><b><big><font face="Times New Roman, Times, serif"><em>Frank Bennett
President</em></font></big></b>

Mathegraphics,LLC
613 Bentley Pl
Fort Collins,CO 80526
970-229-9269 (hm) 970-402-9269 (cell)
<a href="http://www.mathegraphics.com">www.mathegraphics.com</a>
<span style="text-decoration: underline;"><a
 href="mailto:bennett78@lpbroadband.net">bennett78@lpbroadband.net</a>

</span><small><font color="black" face="Courier New" size="2"><small><span
 style="font-size: 10pt;">"I think there's a world market for about five computers."<o:p></o:p></span></small></font><font
 color="black" face="Courier New" size="2"><small><span
 style="font-size: 10pt;">&nbsp; 
-- attr. Thomas J. Watson (Chairman of the Board, IBM), 1943<o:p></o:p></span></small></font><font
 color="black" face="Courier New" size="2"><small><span
 style="font-size: 10pt;"><o:p>&nbsp;</o:p></span></small></font><span
 style="text-decoration: underline;"> 
</span></small></pre>
</div>
</body>
</html>

--------------020107060008070705040403--
