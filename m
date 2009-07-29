Return-Path: <stef.simoens@scarlet.be>
Received: from smtp2.tech.numericable.fr (smtp2.tech.numericable.fr
	[82.216.111.38])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 7996DB7B5F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jul 2009 04:23:01 +1000 (EST)
Message-ID: <4A70937B.7040201@scarlet.be>
Date: Wed, 29 Jul 2009 20:22:51 +0200
From: Stef Simoens <stef.simoens@scarlet.be>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: BUG in dma-mapping.h:218 // MESH SCSI driver not working
References: <4A68E1CE.4040307@scarlet.be> <1248425553.25467.20.camel@pasglop>
In-Reply-To: <1248425553.25467.20.camel@pasglop>
Content-Type: multipart/alternative;
	boundary="------------080505020409050903020209"
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
--------------080505020409050903020209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

Benjamin Herrenschmidt schreef:
> On Fri, 2009-07-24 at 00:18 +0200, Stef Simoens wrote:
>   
>> I tried the latest 2.6.31-rc3-git3 (without any other patch).
>> However, I have the same behaviour as the patched 2.6.30 (so: no BUG, 
>> but the mesh_abort messages).
>>     
> Would it be possible for you to roughly find out at what kernel version
> it stopped working ? (Some kernels may need my patch to avoid crashing)
>   
2.6.29 works OK
2.6.30-rc1 doesn't work (BUG...)
2.6.30-rc1 with your patch ... seems to hang when it should be mounting 
the root directory.

Is it worthwhile doing a git bisect?

-- 
Kind regards,

Stef Simoens



--------------080505020409050903020209
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
  <meta content="text/html;charset=ISO-8859-1" http-equiv="Content-Type">
</head>
<body bgcolor="#ffffff" text="#000000">
Hello,<br>
<br>
Benjamin Herrenschmidt schreef:
<blockquote cite="mid:1248425553.25467.20.camel@pasglop" type="cite">
  <pre wrap="">On Fri, 2009-07-24 at 00:18 +0200, Stef Simoens wrote:
  </pre>
  <blockquote type="cite">
    <pre wrap="">I tried the latest 2.6.31-rc3-git3 (without any other patch).
However, I have the same behaviour as the patched 2.6.30 (so: no BUG, 
but the mesh_abort messages).
    </pre>
  </blockquote>
  <pre wrap=""><!---->Would it be possible for you to roughly find out at what kernel version
it stopped working ? (Some kernels may need my patch to avoid crashing)
  </pre>
</blockquote>
2.6.29 works OK<br>
2.6.30-rc1 doesn't work (BUG...)<br>
2.6.30-rc1 with your patch ... seems to hang when it should be mounting
the root directory.<br>
<br>
Is it worthwhile doing a git bisect?<br>
<pre class="moz-signature" cols="72">-- 
Kind regards,

Stef Simoens

</pre>
</body>
</html>

--------------080505020409050903020209--
