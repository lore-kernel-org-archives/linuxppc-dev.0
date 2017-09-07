Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xp6lt4KqnzDrWV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Sep 2017 03:25:13 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v87HNsdl002240
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Sep 2017 13:25:10 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2cu701kt15-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Sep 2017 13:25:10 -0400
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Thu, 7 Sep 2017 18:25:08 +0100
Subject: Re: [PATCH] cxl: Dump PSL_FIR1/2 registers on PSL9 error irq
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 "Alastair D'Silva" <alastair@au1.ibm.com>
References: <20170907121346.22011-1-vaibhav@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Thu, 7 Sep 2017 19:25:01 +0200
MIME-Version: 1.0
In-Reply-To: <20170907121346.22011-1-vaibhav@linux.vnet.ibm.com>
Content-Type: multipart/alternative;
 boundary="------------246BA602639D995D083A8AB9"
Message-Id: <f83f862b-978b-1345-2f9f-5864c93e9559@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------246BA602639D995D083A8AB9
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 07/09/2017 à 14:13, Vaibhav Jain a écrit :
> For PSL9 currently we aren't dumping the PSL FIR1/2 registers when a
> PSL error interrupt is triggered. Contents of these registers are
> useful in debugging AFU issues.
>
> This patch fixes issue by updating the cxl_native_err_irq_dump_regs()
> to dump these regs on PSL error interrupt thereby bringing the
> behavior in line with PSL on POWER-8.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---
>   drivers/misc/cxl/native.c | 13 +++++++++++--
>   drivers/misc/cxl/pci.c    |  1 +
>   2 files changed, 12 insertions(+), 2 deletions(-)

sounds good.

Acked-by:  Christophe Lombard <clombard@linux.vnet.ibm.com>


--------------246BA602639D995D083A8AB9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 8bit

<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body text="#000000" bgcolor="#FFFFFF">
    <div class="moz-cite-prefix">Le 07/09/2017 à 14:13, Vaibhav Jain a
      écrit :<br>
    </div>
    <blockquote type="cite"
      cite="mid:20170907121346.22011-1-vaibhav@linux.vnet.ibm.com">
      <pre wrap="">For PSL9 currently we aren't dumping the PSL FIR1/2 registers when a
PSL error interrupt is triggered. Contents of these registers are
useful in debugging AFU issues.

This patch fixes issue by updating the cxl_native_err_irq_dump_regs()
to dump these regs on PSL error interrupt thereby bringing the
behavior in line with PSL on POWER-8.

Signed-off-by: Vaibhav Jain <a class="moz-txt-link-rfc2396E" href="mailto:vaibhav@linux.vnet.ibm.com">&lt;vaibhav@linux.vnet.ibm.com&gt;</a>
---
 drivers/misc/cxl/native.c | 13 +++++++++++--
 drivers/misc/cxl/pci.c    |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)
</pre>
    </blockquote>
    <br>
    sounds good.<br>
    <br>
    Acked-by:  Christophe Lombard <a class="moz-txt-link-rfc2396E"
      href="mailto:clombard@linux.vnet.ibm.com">&lt;clombard@linux.vnet.ibm.com&gt;</a><br>
    <br>
  </body>
</html>

--------------246BA602639D995D083A8AB9--
