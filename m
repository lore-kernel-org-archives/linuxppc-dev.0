Return-Path: <srs0=5yjr=53=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtb526NBNzDqjP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 18:55:18 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wtb524cnKz8t3W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 18:55:18 +1000 (AEST)
Message-ID: <1498121654.7935.1.camel@gmail.com>
Subject: Re: 1M hugepage size being registered on Linux
From: Balbir Singh <bsingharora@gmail.com>
To: Mauricio Faria de Oliveira <mauricfo@linux.vnet.ibm.com>, jk@ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Stewart Smith
 <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, victora@br.ibm.com, victora
 <victora@linux.vnet.ibm.com>, alistair@popple.id.au
Date: Thu, 22 Jun 2017 18:54:14 +1000
In-Reply-To: <3493fb6b-5212-843c-60b8-b2b715b52154@linux.vnet.ibm.com>
References: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
 <87wp85sk9o.fsf@concordia.ellerman.id.au>
 <3493fb6b-5212-843c-60b8-b2b715b52154@linux.vnet.ibm.com>
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

On Wed, 2017-06-21 at 12:32 -0300, Mauricio Faria de Oliveira wrote:
> On 06/21/2017 07:33 AM, Michael Ellerman wrote:
> > > I am working on a bug related to 1M hugepage size being registered on
> > > Linux (Power 8 Baremetal - Garrison).
> > Wasn't that caused by a firmware bug?
> 
> Ben/Stewart, does that ring a bell, something new, intended or not? :- )
> 
> 

Aneesh changed the code to support just 16M and 16G hugepages for hash even
if the firmware exported that size. What is your end goal to support those
pages or to prevent them from being used?

Balbir Singh.
