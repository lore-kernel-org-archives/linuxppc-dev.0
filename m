Return-Path: <B42677@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe005.messaging.microsoft.com [65.55.88.15])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E94652C008F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 11:58:12 +1000 (EST)
Message-ID: <5216C267.5060701@freescale.com>
Date: Fri, 23 Aug 2013 10:01:11 +0800
From: Zhang Haijun <B42677@freescale.com>
MIME-Version: 1.0
To: Anton Vorontsov <anton@enomsg.org>
Subject: Re: [PATCH 2/3 V3] mmc:sdhc: get voltage from sdhc host
References: <1376271546-25085-1-git-send-email-Haijun.Zhang@freescale.com>
 <1376271546-25085-4-git-send-email-Haijun.Zhang@freescale.com>
 <20130823014841.GD24803@teo>
In-Reply-To: <20130823014841.GD24803@teo>
Content-Type: multipart/alternative;
 boundary="------------090908050003040501000307"
Cc: linux-mmc@vger.kernel.org, Haijun Zhang <Haijun.Zhang@freescale.com>,
 scottwood@freescale.com, cjb@laptop.org, linuxppc-dev@lists.ozlabs.org,
 X.Xie@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--------------090908050003040501000307
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit

On 08/23/2013 09:48 AM, Anton Vorontsov wrote:
> On Mon, Aug 12, 2013 at 09:39:06AM +0800, Haijun Zhang wrote:
>> We use host->ocr_mask to hold the voltage get from device-tree
>> node, In case host->ocr_mask was available, we use host->ocr_mask
>> as the final available voltage can be used by MMC/SD/SDIO card.
>>
>> Signed-off-by: Haijun Zhang <haijun.zhang@freescale.com>
>> ---
> Reviewed-by: Anton Vorontsov <anton@enomsg.org>
>
Thank you very much.

-- 
Thanks & Regards

Haijun


--------------090908050003040501000307
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <div class="moz-cite-prefix">On 08/23/2013 09:48 AM, Anton Vorontsov
      wrote:<br>
    </div>
    <blockquote cite="mid:20130823014841.GD24803@teo" type="cite">
      <pre wrap="">On Mon, Aug 12, 2013 at 09:39:06AM +0800, Haijun Zhang wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="">We use host-&gt;ocr_mask to hold the voltage get from device-tree
node, In case host-&gt;ocr_mask was available, we use host-&gt;ocr_mask
as the final available voltage can be used by MMC/SD/SDIO card.

Signed-off-by: Haijun Zhang <a class="moz-txt-link-rfc2396E" href="mailto:haijun.zhang@freescale.com">&lt;haijun.zhang@freescale.com&gt;</a>
---
</pre>
      </blockquote>
      <pre wrap="">
Reviewed-by: Anton Vorontsov <a class="moz-txt-link-rfc2396E" href="mailto:anton@enomsg.org">&lt;anton@enomsg.org&gt;</a>

</pre>
    </blockquote>
    <font size="-1"><font size="-1">Thank you very m<font size="-1">uch.</font></font></font><br>
    <br>
    <pre class="moz-signature" cols="72">-- 
Thanks &amp; Regards

Haijun</pre>
  </body>
</html>

--------------090908050003040501000307--
