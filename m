Return-Path: <walken@google.com>
Received: from mail-ia0-x230.google.com (mail-ia0-x230.google.com
 [IPv6:2607:f8b0:4001:c02::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C1CC32C009B
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 19:08:14 +1100 (EST)
Received: by mail-ia0-f176.google.com with SMTP id i1so47817iaa.35
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 01:08:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130221230557.8BDCA5A4174@corp2gmr1-2.hot.corp.google.com>
References: <20130221230557.8BDCA5A4174@corp2gmr1-2.hot.corp.google.com>
Date: Mon, 18 Mar 2013 01:08:10 -0700
Message-ID: <CANN689EuRDmoMaUE6E9kv2C70SY556MQAhopxCXCm6=gwuuPPg@mail.gmail.com>
Subject: Re: [patch 1/2] mm: remove free_area_cache use in powerpc architecture
From: Michel Lespinasse <walken@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Cc: riel@redhat.com, akpm@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 21, 2013 at 3:05 PM,  <akpm@linux-foundation.org> wrote:
> From: Michel Lespinasse <walken@google.com>
> Subject: mm: remove free_area_cache use in powerpc architecture
>
> As all other architectures have been converted to use vm_unmapped_area(),
> we are about to retire the free_area_cache.

Ping ? I haven't seen any replies from the ppc maintainers, and
powerpc is now the only remaining user of free_area_cache. Could you
please take these two patches ?

Thanks,

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
