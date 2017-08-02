Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMtNM4yHzzDsS7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 22:51:14 +1000 (AEST)
Date: Wed, 2 Aug 2017 07:50:07 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Anton Blanchard <anton@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 16/17] powerpc/mm/pseries: Move slot based bulk remove
 to helper
Message-ID: <20170802125007.GN13471@gate.crashing.org>
References: <20170802054016.8927-1-aneesh.kumar@linux.vnet.ibm.com>
 <20170802054016.8927-17-aneesh.kumar@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170802054016.8927-17-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Aneesh,

On Wed, Aug 02, 2017 at 11:10:15AM +0530, Aneesh Kumar K.V wrote:
> +static int plpar_bluk_remove(unsigned long *param, int index, unsigned long slot,

s/bluk/bulk/ :-)


Segher
