Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 79DC62C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 19:19:46 +1100 (EST)
Message-ID: <1363594759.12419.1.camel@pasglop>
Subject: Re: [patch 1/2] mm: remove free_area_cache use in powerpc architecture
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel Lespinasse <walken@google.com>
Date: Mon, 18 Mar 2013 09:19:19 +0100
In-Reply-To: <CANN689EuRDmoMaUE6E9kv2C70SY556MQAhopxCXCm6=gwuuPPg@mail.gmail.com>
References: <20130221230557.8BDCA5A4174@corp2gmr1-2.hot.corp.google.com>
 <CANN689EuRDmoMaUE6E9kv2C70SY556MQAhopxCXCm6=gwuuPPg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: riel@redhat.com, dwg@au1.ibm.com, Paul Mackerras <paulus@samba.org>,
 "Aneesh Kumar
 K.V" <aneesh.kumar@linux.vnet.ibm.com>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-03-18 at 01:08 -0700, Michel Lespinasse wrote:
> On Thu, Feb 21, 2013 at 3:05 PM,  <akpm@linux-foundation.org> wrote:
> > From: Michel Lespinasse <walken@google.com>
> > Subject: mm: remove free_area_cache use in powerpc architecture
> >
> > As all other architectures have been converted to use vm_unmapped_area(),
> > we are about to retire the free_area_cache.
> 
> Ping ? I haven't seen any replies from the ppc maintainers, and
> powerpc is now the only remaining user of free_area_cache. Could you
> please take these two patches ?

Ah the ppc maintainer was totally swamped (and now on vacation) and was
hoping somebody else would review & test that ... 

Aneesh, David, can you have a look ?

Thanks !

Cheers,
Ben.
