Return-Path: <B42677@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 71E5F2C00D9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Aug 2013 12:44:36 +1000 (EST)
Message-ID: <52084C7E.9000706@freescale.com>
Date: Mon, 12 Aug 2013 10:46:22 +0800
From: Zhang Haijun <B42677@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/3 V2] mmc:core: parse voltage from device-tree
References: <1375251927-3330-1-git-send-email-Haijun.Zhang@freescale.com>
 <733059D3-105A-437B-B330-763D2C1859B2@kernel.crashing.org>
In-Reply-To: <733059D3-105A-437B-B330-763D2C1859B2@kernel.crashing.org>
Content-Type: multipart/alternative;
 boundary="------------070007000903050701070905"
Cc: linux-mmc@vger.kernel.org, cbouatmailru@gmail.com, scottwood@freescale.com,
 cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 Haijun Zhang <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------070007000903050701070905
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/09/2013 10:48 PM, Kumar Gala wrote:
> On Jul 31, 2013, at 1:25 AM, Haijun Zhang wrote:
>
>> Add function to support get voltage from device-tree.
>> If there are voltage-range specified in device-tree node, this function
>> will parse it and return the avail voltage mask.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> ---
>> changes for v2:
>> 	- Update the parameters of function
>>
>> drivers/mmc/core/core.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>> include/linux/mmc/core.h |  1 +
>> 2 files changed, 47 insertions(+)
> There should be a device tree binding spec update to go with this patch series.
>
> - k
Hi, kumar

I'll update this tree binding spec after the patch set is accept by Anton.

-- 
Thanks & Regards

Haijun


--------------070007000903050701070905
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=ISO-8859-1"
      http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 08/09/2013 10:48 PM, Kumar Gala
      wrote:<br>
    </div>
    <blockquote
      cite="mid:733059D3-105A-437B-B330-763D2C1859B2@kernel.crashing.org"
      type="cite">
      <pre wrap="">
On Jul 31, 2013, at 1:25 AM, Haijun Zhang wrote:

</pre>
      <blockquote type="cite">
        <pre wrap="">Add function to support get voltage from device-tree.
If there are voltage-range specified in device-tree node, this function
will parse it and return the avail voltage mask.

Signed-off-by: Haijun Zhang <a class="moz-txt-link-rfc2396E" href="mailto:haijun.zhang@freescale.com">&lt;haijun.zhang@freescale.com&gt;</a>
---
changes for v2:
	- Update the parameters of function

drivers/mmc/core/core.c  | 46 ++++++++++++++++++++++++++++++++++++++++++++++
include/linux/mmc/core.h |  1 +
2 files changed, 47 insertions(+)
</pre>
      </blockquote>
      <pre wrap="">
There should be a device tree binding spec update to go with this patch series.

- k
</pre>
    </blockquote>
    <font size="-1"><font size="-1">Hi, kumar<br>
        <br>
        <font size="-1">I'll update <font size="-1">this tree bin<font
              size="-1">ding spec <font size="-1">after the patch set
                is acce<font size="-1">pt by Anton.</font></font></font></font></font><br>
      </font></font><br>
    <pre class="moz-signature" cols="72">-- 
Thanks &amp; Regards

Haijun</pre>
  </body>
</html>

--------------070007000903050701070905--
