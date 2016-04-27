Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvntm1qykzDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 15:04:15 +1000 (AEST)
Received: from localhost
 by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Wed, 27 Apr 2016 01:04:13 -0400
Received: from b01cxnp23032.gho.pok.ibm.com (b01cxnp23032.gho.pok.ibm.com
 [9.57.198.27])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id A71C7C90043
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 01:04:03 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23032.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3R549IO36765742
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 05:04:09 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3R4vTYF016198
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 00:57:30 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>, arnd@arndb.de
Cc: devicetree@vger.kernel.org,
 Suraj Jitindar Singh <sjitindarsingh@gmail.com>,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 andrew.donnellan@au1.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 1/2] devicetree/bindings: Add binding for operator
 panel on FSP machines
In-Reply-To: <1460423107-7270-1-git-send-email-sjitindarsingh@gmail.com>
References: <1460423107-7270-1-git-send-email-sjitindarsingh@gmail.com>
Date: Wed, 27 Apr 2016 15:03:28 +1000
Message-ID: <87mvofiqxr.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Suraj Jitindar Singh <sjitindarsingh@gmail.com> writes:
> Add a binding to Documentation/devicetree/bindings/powerpc/opal
> (oppanel-opal.txt) for the operator panel which is present on IBM
> pseries machines with FSPs.

It's not pseries (as that implies PowerVM / PAPR) - while here we're all
about OPAL.

With a slight change to the commit message,
Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>


-- 
Stewart Smith
OPAL Architect, IBM.
