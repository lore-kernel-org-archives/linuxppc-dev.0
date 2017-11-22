Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yhdhr5fCWzDqwP
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Nov 2017 21:18:52 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Philippe Bergheaud <philippe.bergheaud@fr.ibm.com>,
 Alastair D'Silva <alastair@linux.ibm.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Christophe Lombard <christophe_lombard@fr.ibm.com>
Subject: Re: [PATCH v2] cxl: Check if vphb exists before iterating over AFU
 devices
In-Reply-To: <20171122080809.14494-1-vaibhav@linux.vnet.ibm.com>
References: <20171122080809.14494-1-vaibhav@linux.vnet.ibm.com>
Date: Wed, 22 Nov 2017 21:18:51 +1100
Message-ID: <87r2sq39bo.fsf@concordia.ellerman.id.au>
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

Vaibhav Jain <vaibhav@linux.vnet.ibm.com> writes:

> During an eeh a kernel-oops is reported if no vPHB to allocated to the
> AFU. This happens as during AFU init, an error in creation of vPHB is
> a non-fatal error. Hence afu->phb should always be checked for NULL
> before iterating over it for the virtual AFU pci devices.
>
> This patch fixes the kenel-oops by adding a NULL pointer check for
> afu->phb before it is dereferenced.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
>
> ---
> Changelog:
> v2 -> Added the vphb NULL check to cxl_vphb_error_detected() [Andrew]

Fixes: ?

Stable?

cheers
