Return-Path: <clombard@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40Pn7t1J1BzF1sD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 22:02:49 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3GBxMXq140177
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 08:02:47 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2hcrr17v6g-1
 (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Apr 2018 08:02:45 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clombard@linux.vnet.ibm.com>;
 Mon, 16 Apr 2018 13:02:44 +0100
Subject: Re: [PATCH v2] cxl: Set the PBCQ Tunnel BAR register when enabling
 capi mode
To: Philippe Bergheaud <felix@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: fbarrat@linux.ibm.com, clombard@linux.ibm.com, benh@au1.ibm.com
References: <20180413115939.25269-1-felix@linux.ibm.com>
From: christophe lombard <clombard@linux.vnet.ibm.com>
Date: Mon, 16 Apr 2018 14:02:40 +0200
MIME-Version: 1.0
In-Reply-To: <20180413115939.25269-1-felix@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a0df6c8b-a763-232e-dce1-585db9013d2f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 13/04/2018 à 13:59, Philippe Bergheaud a écrit :
> Skiboot used to set the default Tunnel BAR register value when capi mode
> was enabled. This approach was ok for the cxl driver, but prevented other
> drivers from choosing different values.
> 
> Skiboot versions > 5.11 will not set the default value any longer. This
> patch modifies the cxl driver to set/reset the Tunnel BAR register when
> entering/exiting the cxl mode, with pnv_pci_set_tunnel_bar().
> 
> Signed-off-by: Philippe Bergheaud <felix@linux.ibm.com>
> ---

Thanks

Reviewed-by: Christophe Lombard <clombard@linux.vnet.ibm.com>
