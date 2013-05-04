Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6614D2C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  5 May 2013 07:39:37 +1000 (EST)
Message-ID: <1367703559.11982.1.camel@pasglop>
Subject: Re: [PATCH -V7 02/10] powerpc/THP: Implement transparent hugepages
 for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Sun, 05 May 2013 07:39:19 +1000
In-Reply-To: <87a9oa4kx0.fsf@linux.vnet.ibm.com>
References: <1367178711-8232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367178711-8232-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130503045201.GO13041@truffula.fritz.box>
 <87a9oa4kx0.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linux-mm@kvack.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2013-05-05 at 00:44 +0530, Aneesh Kumar K.V wrote:
> 
> We may want to retain some of these because of the assert we want to add
> for locking. PTE related functions expect ptl to be locked. PMD related
> functions expect mm->page_table_lock to be locked.

In this case have a single inline commmon function __something called
by two different wrappers.

Cheers,
Ben.
