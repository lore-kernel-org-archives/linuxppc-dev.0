Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w3jFG28vmzDq7g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 00:03:46 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3DE3ckd090068
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 10:03:43 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29ssdmj81y-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Apr 2017 10:03:43 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Fri, 14 Apr 2017 00:03:39 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3DE3Shs35520722
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 00:03:36 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3DE314u023461
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Apr 2017 00:03:04 +1000
Subject: Re: [PATCH v2 02/11] ABI: fix some syntax issues at the ABI database
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
 Linux Doc Mailing List <linux-doc@vger.kernel.org>,
 Jonathan Corbet <corbet@lwn.net>
References: <cover.1492077070.git.mchehab@s-opensource.com>
 <20170413102612.BA6BCC603E@b03ledav006.gho.boulder.ibm.com>
Cc: Matt Ranostay <mranostay@gmail.com>,
 Markus Heiser <markus.heiser@darmarIT.de>,
 Tony Luck <tony.luck@intel.com>, Kees Cook <keescook@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Anton Vorontsov <anton@enomsg.org>, LKML <linux-kernel@vger.kernel.org>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Mauro Carvalho Chehab <mchehab@infradead.org>,
 Ian Munsie <imunsie@au1.ibm.com>, Colin Cross <ccross@android.com>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Cameron <jic23@kernel.org>,
 Andreas Klinger <ak@it-klinger.de>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Fri, 14 Apr 2017 00:02:34 +1000
MIME-Version: 1.0
In-Reply-To: <20170413102612.BA6BCC603E@b03ledav006.gho.boulder.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <fba08ee1-552d-0871-015d-67ff24b55857@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/04/17 20:08, Mauro Carvalho Chehab wrote:
> diff --git a/Documentation/ABI/testing/sysfs-class-cxl b/Documentation/ABI/testing/sysfs-class-cxl
> index 640f65e79ef1..d0b32452dfe1 100644
> --- a/Documentation/ABI/testing/sysfs-class-cxl
> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> @@ -1,6 +1,6 @@
> -Note: Attributes that are shared between devices are stored in the directory
> -pointed to by the symlink device/.
> -Example: The real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
> +Please notice that attributes that are shared between devices are stored in
> +the directory pointed to by the symlink device/.
> +For example, the real path of the attribute /sys/class/cxl/afu0.0s/irqs_max is
>  /sys/class/cxl/afu0.0s/device/irqs_max, i.e. /sys/class/cxl/afu0.0/irqs_max.

If you end up respinning this, I'd prefer "Note that" or "Please note 
that" rather than "Please notice". Otherwise, for cxl:

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
