Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wxkMW1p1QzDr3D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 21:33:43 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id f127so3987292pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jun 2017 04:33:43 -0700 (PDT)
Message-ID: <1498563169.7935.16.camel@gmail.com>
Subject: Re: [RFC v4 02/17] mm: ability to disable execute permission on a
 key at creation
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org,  x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org,  corbet@lwn.net, mingo@redhat.com
Date: Tue, 27 Jun 2017 21:32:49 +1000
In-Reply-To: <1498558319-32466-3-git-send-email-linuxram@us.ibm.com>
References: <1498558319-32466-1-git-send-email-linuxram@us.ibm.com>
 <1498558319-32466-3-git-send-email-linuxram@us.ibm.com>
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

On Tue, 2017-06-27 at 03:11 -0700, Ram Pai wrote:
> Currently sys_pkey_create() provides the ability to disable read
> and write permission on the key, at  creation. powerpc  has  the
> hardware support to disable execute on a pkey as well.This patch
> enhances the interface to let disable execute  at  key  creation
> time. x86 does  not  allow  this.  Hence the next patch will add
> ability  in  x86  to  return  error  if  PKEY_DISABLE_EXECUTE is
> specified.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
