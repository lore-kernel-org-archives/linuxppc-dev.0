Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 214671A175E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 16:52:12 +1000 (EST)
Message-ID: <1412146289.4285.202.camel@pasglop>
Subject: Re: [PATCH v2 02/17] powerpc/cell: Move data segment faulting code
 out of cell platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Date: Wed, 01 Oct 2014 16:51:29 +1000
In-Reply-To: <20141001064757.BFF88140174@ozlabs.org>
References: <20141001064757.BFF88140174@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: cbe-oss-dev@lists.ozlabs.org, Michael Neuling <mikey@neuling.org>,
 arnd@arndb.de, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, greg@kroah.com,
 linux-kernel@vger.kernel.org, imunsie@au.ibm.com, linuxppc-dev@ozlabs.org,
 anton@samba.org, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 16:47 +1000, Michael Ellerman wrote:
> 
> If we give it a name that says what it does, we get
> copro_get_ea_esid_and_vsid().
> Or something equally ugly.

copro_calc_full_va() ?

Ben.
