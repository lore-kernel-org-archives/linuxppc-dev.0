Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 38C1B2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Feb 2013 14:46:59 +1100 (EST)
Message-ID: <1360727211.2035.30.camel@pasglop>
Subject: Re: [PATCH 2/2] powerpc: Make context bits depend on virtual addr
 size.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 13 Feb 2013 14:46:51 +1100
In-Reply-To: <87sj50kian.fsf@linux.vnet.ibm.com>
References: <1360693905-23503-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360693905-23503-2-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1360701185.2035.10.camel@pasglop> <87sj50kian.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-02-13 at 08:54 +0530, Aneesh Kumar K.V wrote:
> > A compile option ? Really ? Ugh...
> 
> I actually wanted that to be done in Kconfig.cputype, but haven't found
> a nice way to do it. Considering we are switching between only two
> values, I was thinking an #ifdef would work.

No, we want to support all those processor types from a single kernel image.

Ben.
