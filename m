Return-Path: <gautran@mrv.com>
Received: from mailman.xyplex.com (mailman.xyplex.com [140.179.176.116])
	by ozlabs.org (Postfix) with ESMTP id EB9A967A6E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Mar 2005 06:01:02 +1100 (EST)
Message-ID: <423F1A05.4080308@mrv.com>
Date: Mon, 21 Mar 2005 14:01:25 -0500
From: Guillaume Autran <gautran@mrv.com>
MIME-Version: 1.0
To: Eugene Surovegin <ebs@ebshome.net>
References: <423F0FFB.10307@mrv.com> <20050321185056.GB11734@gate.ebshome.net>
In-Reply-To: <20050321185056.GB11734@gate.ebshome.net>
Content-Type: multipart/alternative;
	boundary="------------080901020005020508000503"
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: MPC885 CryptoApi support.
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
--------------080901020005020508000503
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Eugene Surovegin wrote:

>On Mon, Mar 21, 2005 at 01:18:35PM -0500, Guillaume Autran wrote:
>  
>
>>Is there any open source development done to integrate the MPC885 
>>security coprocessor into the linux 2.6 kernel CryptoApi framework ?
>>Did anyone wrote a driver for it yet ?
>>    
>>
>
>Current kernel CryptoAPI is lacking sane support for hw crypto engines 
>(e.g. there is no async crypto). Until there is such generic support, 
>it's highly difficult to efficiently integrate hw crypto into the 
>kernel. I did such stuff for Hifn 7955 accelerator and didn't like the 
>result :).
>
>--
>Eugene
>
>  
>
Thanks Eugene,
Do you know if anybody is working on HW crypto engine support ?


Regards,
Guillaume.

-- 
=======================================
Guillaume Autran
Senior Software Engineer
MRV Communications, Inc.
Tel: (978) 952-4932 office
E-mail: gautran@mrv.com
======================================= 


--------------080901020005020508000503
Content-Type: text/html; charset=us-ascii
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta http-equiv="Content-Type" content="text/html;charset=ISO-8859-1">
  <title></title>
</head>
<body text="#000000" bgcolor="#ffffff">
Eugene Surovegin wrote:<br>
<blockquote type="cite"
 cite="mid20050321185056.GB11734@gate.ebshome.net">
  <pre wrap="">On Mon, Mar 21, 2005 at 01:18:35PM -0500, Guillaume Autran wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">Is there any open source development done to integrate the MPC885 
security coprocessor into the linux 2.6 kernel CryptoApi framework ?
Did anyone wrote a driver for it yet ?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
Current kernel CryptoAPI is lacking sane support for hw crypto engines 
(e.g. there is no async crypto). Until there is such generic support, 
it's highly difficult to efficiently integrate hw crypto into the 
kernel. I did such stuff for Hifn 7955 accelerator and didn't like the 
result :).

--
Eugene

  </pre>
</blockquote>
Thanks Eugene,<br>
Do you know if anybody is working on HW crypto engine support ? <br>
<br>
<br>
Regards,<br>
Guillaume.<br>
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

--------------080901020005020508000503--
