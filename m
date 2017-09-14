Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtB896p1rzDqXp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 18:11:53 +1000 (AEST)
Message-ID: <1505376692.12628.191.camel@kernel.crashing.org>
Subject: Re: [PATCH 02/25] powerpc: define an additional vma bit for
 protection keys.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Balbir Singh <bsingharora@gmail.com>, Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Date: Thu, 14 Sep 2017 18:11:32 +1000
In-Reply-To: <20170914143807.03cd9aa3@firefly.ozlabs.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-11-git-send-email-linuxram@us.ibm.com>
 <20170914143807.03cd9aa3@firefly.ozlabs.ibm.com>
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

On Thu, 2017-09-14 at 14:38 +1000, Balbir Singh wrote:
> On Fri,  8 Sep 2017 15:44:50 -0700
> Ram Pai <linuxram@us.ibm.com> wrote:
> 
> > powerpc needs an additional vma bit to support 32 keys.
> > Till the additional vma bit lands in include/linux/mm.h
> > we have to define  it  in powerpc specific header file.
> > This is  needed to get pkeys working on power.
> > 
> > Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> > ---
> 
> "This" being an arch specific hack for the additional bit?

Arch VMA bits ? really ? I'd rather we limit ourselves to 16 keys first
then push for adding the extra bit to the generic code.

Ben.
