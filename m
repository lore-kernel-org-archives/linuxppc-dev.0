Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w2l6P5TqlzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Apr 2017 10:24:29 +1000 (AEST)
Received: by mail-pg0-x244.google.com with SMTP id 79so2200196pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Apr 2017 17:24:29 -0700 (PDT)
Message-ID: <1491956661.8380.9.camel@gmail.com>
Subject: Re: [PATCH 5/9] powerpc/vmemmap: Add altmap support
From: Balbir Singh <bsingharora@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: arbab@linux.vnet.ibm.com, linux-nvdimm@lists.01.org
Date: Wed, 12 Apr 2017 10:24:21 +1000
In-Reply-To: <20170411174233.21902-6-oohall@gmail.com>
References: <20170411174233.21902-1-oohall@gmail.com>
 <20170411174233.21902-6-oohall@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-04-12 at 03:42 +1000, Oliver O'Halloran wrote:
> Adds support to powerpc for the altmap feature of ZONE_DEVICE memory. An
> altmap is a driver provided region that is used to provide the backing
> storage for the struct pages of ZONE_DEVICE memory. In situations where
> large amount of ZONE_DEVICE memory is being added to the system the
> altmap reduces pressure on main system memory by allowing the mm/
> metadata to be stored on the device itself rather in main memory.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---

Reviewed-by: Balbir Singh <bsingharora@gmail.com>
