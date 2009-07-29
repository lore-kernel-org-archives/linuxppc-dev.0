Return-Path: <stef.simoens@scarlet.be>
Received: from smtp1.tech.numericable.fr (smtp1.tech.numericable.fr
	[82.216.111.37])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 62565B7B79
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 09:42:28 +1000 (EST)
Message-ID: <4A70DE54.5090406@scarlet.be>
Date: Thu, 30 Jul 2009 01:42:12 +0200
From: Stef Simoens <stef.simoens@scarlet.be>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: BUG in dma-mapping.h:218 // MESH SCSI driver not working
References: <4A68E1CE.4040307@scarlet.be>	 <1248425553.25467.20.camel@pasglop>
	<4A70937B.7040201@scarlet.be> <1248910358.1509.27.camel@pasglop>
In-Reply-To: <1248910358.1509.27.camel@pasglop>
Content-Type: multipart/alternative;
	boundary="------------020200000608040304040002"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------020200000608040304040002
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Benjamin Herrenschmidt schreef:
> On Wed, 2009-07-29 at 20:22 +0200, Stef Simoens wrote:
>   
>> 2.6.29 works OK
>> 2.6.30-rc1 doesn't work (BUG...)
>> 2.6.30-rc1 with your patch ... seems to hang when it should be
>> mounting the root directory.
>>
>> Is it worthwhile doing a git bisect?
>>     
>
> It probably is, since it should work with my patch, so something else
> changed, maybe in the SCSI stack.
>   
What would be the best approach?
- if the kernel boots, it's obviously 'good'
- but what if the kernel hits the 'BUG', should I apply your patch then? 
If it doesn't work with your patch, would it be 'bad' then?
> One thing I know is that the MESH HW has "issues" that make it very
> sensitive to alignment DMA buffers, it's possible that the SCSI stack no
> longer aligns some stuff ?
>   
Hmm, great... how can I verify this?

-- 
Regards,
Stef Simoens


--------------020200000608040304040002
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
  <title></title>
</head>
<body bgcolor="#ffffff" text="#000000">
Benjamin Herrenschmidt schreef:
<blockquote cite="mid:1248910358.1509.27.camel@pasglop" type="cite">
  <pre wrap="">On Wed, 2009-07-29 at 20:22 +0200, Stef Simoens wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">2.6.29 works OK
2.6.30-rc1 doesn't work (BUG...)
2.6.30-rc1 with your patch ... seems to hang when it should be
mounting the root directory.

Is it worthwhile doing a git bisect?
    </pre>
  </blockquote>
  <pre wrap=""><!---->
It probably is, since it should work with my patch, so something else
changed, maybe in the SCSI stack.
  </pre>
</blockquote>
What would be the best approach?<br>
- if the kernel boots, it's obviously 'good'<br>
- but what if the kernel hits the 'BUG', should I apply your patch
then? If it doesn't work with your patch, would it be 'bad' then?<br>
<blockquote cite="mid:1248910358.1509.27.camel@pasglop" type="cite">
  <pre wrap="">One thing I know is that the MESH HW has "issues" that make it very
sensitive to alignment DMA buffers, it's possible that the SCSI stack no
longer aligns some stuff ?
  </pre>
</blockquote>
Hmm, great... how can I verify this?<br>
<pre class="moz-signature" cols="72">-- 
Regards,
Stef Simoens</pre>
</body>
</html>

--------------020200000608040304040002--
