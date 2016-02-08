Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 136751A0190
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 14:02:58 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Sun, 7 Feb 2016 20:02:56 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id AA2A01FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Feb 2016 19:51:04 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id u1832sD122872272
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 Feb 2016 20:02:54 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1832r2K032249
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 7 Feb 2016 20:02:54 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>, imunsie@au1.ibm.com,
 michael.neuling@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 13/18] cxl: sysfs support for guests
In-Reply-To: <1454765345-7417-14-git-send-email-fbarrat@linux.vnet.ibm.com>
References: <1454765345-7417-1-git-send-email-fbarrat@linux.vnet.ibm.com>
 <1454765345-7417-14-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Mon, 08 Feb 2016 14:02:12 +1100
Message-ID: <877fifykej.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:
> --- a/Documentation/ABI/testing/sysfs-class-cxl
> +++ b/Documentation/ABI/testing/sysfs-class-cxl
> @@ -183,7 +183,7 @@ Description:    read only
>                  Identifies the revision level of the PSL.
>  Users:		https://github.com/ibm-capi/libcxl
>  
> -What:           /sys/class/cxl/<card>/base_image
> +What:           /sys/class/cxl/<card>/base_image (not in a guest)

Is this going to be the case for KVM guest as well as PowerVM guest?

-- 
Stewart Smith
OPAL Architect, IBM.
