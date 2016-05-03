Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qzYnP5dgSzDq9s
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 May 2016 18:12:41 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id p185so990818pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 May 2016 01:12:41 -0700 (PDT)
Subject: Re: [RFC 3/7] powerpc/mm: Define TOP_ZONE as a constant
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
References: <1462256966-19321-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1462256966-19321-4-git-send-email-khandual@linux.vnet.ibm.com>
Cc: mikey@neuling.org, oohall@gmail.com, aneesh.kumar@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <57285D71.1060208@gmail.com>
Date: Tue, 3 May 2016 18:12:33 +1000
MIME-Version: 1.0
In-Reply-To: <1462256966-19321-4-git-send-email-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 03/05/16 16:29, Anshuman Khandual wrote:
> From: Oliver O'Halloran <oohall@gmail.com>
> 
> The zone that contains the top of the memory will be either ZONE_NORMAL
> or ZONE_HIGHMEM depending on the kernel config. There are two functions
> in there which require this information and both of them use an #ifdef
> to set a local variable (top_zone). This is a little nuts, so lets just
> make it a constant.
> 
> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
> ---
Looks good
Reviewed-by: Balbir Singh <bsingharora@gmail.com>
