Return-Path: <neelegup@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D8D21A0D07
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 May 2015 02:32:18 +1000 (AEST)
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9528914076A
 for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2015 02:32:17 +1000 (AEST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <neelegup@linux.vnet.ibm.com>;
 Fri, 1 May 2015 22:02:13 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D47B41258053
 for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2015 22:04:12 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t41GW9Qk2032082
 for <linuxppc-dev@ozlabs.org>; Fri, 1 May 2015 22:02:09 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t41G1Rkh004750
 for <linuxppc-dev@ozlabs.org>; Fri, 1 May 2015 21:31:28 +0530
Message-ID: <5543AA87.9020009@linux.vnet.ibm.com>
Date: Fri, 01 May 2015 22:02:07 +0530
From: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Silence SYSPARAM warning on boot
References: <1430365807-14493-1-git-send-email-joel@jms.id.au>
In-Reply-To: <1430365807-14493-1-git-send-email-joel@jms.id.au>
Content-Type: multipart/alternative;
 boundary="------------040304050506050400010000"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------040304050506050400010000
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit



On 04/30/2015 09:20 AM, Joel Stanley wrote:
> OpenPower BMC machines do not place any sysparams in the device tree, so
> at every boot we get a warning:
>
>   [    0.437176] SYSPARAM: Opal sysparam node not found
>
> Remove the warning, and reorder the init so we don't peform allocations
> when there is no sysparam node in the device tree.

Acked-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>

>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>   arch/powerpc/platforms/powernv/opal-sysparam.c | 31 +++++++++++++-------------
>   1 file changed, 15 insertions(+), 16 deletions(-)
>
>

--------------040304050506050400010000
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<html>
  <head>
    <meta content="text/html; charset=utf-8" http-equiv="Content-Type">
  </head>
  <body bgcolor="#FFFFFF" text="#000000">
    <br>
    <br>
    <div class="moz-cite-prefix">On 04/30/2015 09:20 AM, Joel Stanley
      wrote:<br>
    </div>
    <blockquote
      cite="mid:1430365807-14493-1-git-send-email-joel@jms.id.au"
      type="cite">
      <pre wrap="">OpenPower BMC machines do not place any sysparams in the device tree, so
at every boot we get a warning:

 [    0.437176] SYSPARAM: Opal sysparam node not found

Remove the warning, and reorder the init so we don't peform allocations
when there is no sysparam node in the device tree.</pre>
    </blockquote>
    <br>
    <small>Acked-by: Neelesh Gupta <a class="moz-txt-link-rfc2396E" href="mailto:neelegup@linux.vnet.ibm.com">&lt;neelegup@linux.vnet.ibm.com&gt;</a></small><br>
    <br>
    <blockquote
      cite="mid:1430365807-14493-1-git-send-email-joel@jms.id.au"
      type="cite">
      <pre wrap="">

Signed-off-by: Joel Stanley <a class="moz-txt-link-rfc2396E" href="mailto:joel@jms.id.au">&lt;joel@jms.id.au&gt;</a>
---
 arch/powerpc/platforms/powernv/opal-sysparam.c | 31 +++++++++++++-------------
 1 file changed, 15 insertions(+), 16 deletions(-)


</pre>
    </blockquote>
  </body>
</html>

--------------040304050506050400010000--
