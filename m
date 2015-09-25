Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF1E41A0014
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 11:09:00 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 25 Sep 2015 11:08:59 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 589BD357804F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 11:08:55 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8P18bZE53018854
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 11:08:45 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8P18M4Q009743
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2015 11:08:23 +1000
Message-ID: <56049E83.8060503@au1.ibm.com>
Date: Fri, 25 Sep 2015 11:08:19 +1000
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>, Tomas Henzl <thenzl@redhat.com>,
 David Laight <David.Laight@ACULAB.COM>
CC: Michael Neuling <mikey@neuling.org>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 29/32] MAINTAINERS: Add cxlflash driver
References: <1443123193-16498-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1443123841-17817-1-git-send-email-mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443123841-17817-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 25/09/15 05:44, Matthew R. Ochs wrote:
> Add stanza for cxlflash SCSI driver.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> Reviewed-by: Brian King <brking@linux.vnet.ibm.com>

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

> ---
>   MAINTAINERS | 9 +++++++++
>   1 file changed, 9 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 274f854..f2f3046 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3153,6 +3153,15 @@ F:	Documentation/powerpc/cxl.txt
>   F:	Documentation/powerpc/cxl.txt
>   F:	Documentation/ABI/testing/sysfs-class-cxl
>
> +CXLFLASH (IBM Coherent Accelerator Processor Interface CAPI Flash) SCSI DRIVER
> +M:	Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> +M:	Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> +L:	linux-scsi@vger.kernel.org
> +S:	Supported
> +F:	drivers/scsi/cxlflash/
> +F:	include/uapi/scsi/cxlflash_ioctls.h
> +F:	Documentation/powerpc/cxlflash.txt
> +
>   STMMAC ETHERNET DRIVER
>   M:	Giuseppe Cavallaro <peppe.cavallaro@st.com>
>   L:	netdev@vger.kernel.org
>

-- 
Andrew Donnellan              Software Engineer, OzLabs
andrew.donnellan@au1.ibm.com  Australia Development Lab, Canberra
+61 2 6201 8874 (work)        IBM Australia Limited
