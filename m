Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zwjd42tQ4zF1bW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2018 03:57:44 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w26GsL7I070517
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 6 Mar 2018 11:57:41 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ghwjd4jtj-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Mar 2018 11:57:41 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Tue, 6 Mar 2018 16:57:39 -0000
Subject: Re: [PATCH v10 2/2] cxl: read PHB indications from the device tree
To: Philippe Bergheaud <felix@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.vnet.ibm.com, benh@au1.ibm.com
References: <20180302095612.19493-1-felix@linux.vnet.ibm.com>
 <20180302095612.19493-2-felix@linux.vnet.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Tue, 6 Mar 2018 17:57:36 +0100
MIME-Version: 1.0
In-Reply-To: <20180302095612.19493-2-felix@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <456cb09c-f6cf-b6f7-b150-d66ba01098c9@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 02/03/2018 à 10:56, Philippe Bergheaud a écrit :
> Configure the P9 XSL_DSNCTL register with PHB indications found
> in the device tree, or else use legacy hard-coded values.
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.vnet.ibm.com>
> Reviewed-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
> ---
> Changelog:
> 
> v2: New patch. Use the new device tree property "ibm,phb-indications".
> 
> v3: No change.
> 
> v4: No functional change.
>      Drop cosmetic fix in comment.
> 
> v5: get_phb_indications():
>        - make static variables local to function.
>        - return static variable values by arguments.
> 
> v6: get_phb_indications():
>        - acquire a mutex before setting the phb indications.
> 
> v7: get_phb_indications():
>      cxl_get_xsl9_dsnctl():
>        - return -ENODEV instead of -1.
> 
> v8: get_phb_indications():
>        - stay on the safe side: acquire the mutex unconditionally
> 
> v9,v10: No change.
> ---

Reviewed-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
