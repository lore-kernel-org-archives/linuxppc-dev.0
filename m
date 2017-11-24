Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yjmgQ5z1jzDrbC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Nov 2017 17:36:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Rob Herring <robh@kernel.org>, Oliver O'Halloran <oohall@gmail.com>
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-nvdimm@lists.01.org
Subject: Re: [PATCH 2/3] libnvdimm: Add a device-tree interface
In-Reply-To: <20171116142840.er7st25ll3o6jr7s@rob-hp-laptop>
References: <20171115175131.23631-1-oohall@gmail.com>
 <20171115175131.23631-2-oohall@gmail.com>
 <20171116142840.er7st25ll3o6jr7s@rob-hp-laptop>
Date: Fri, 24 Nov 2017 17:36:33 +1100
Message-ID: <87ine018um.fsf@concordia.ellerman.id.au>
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

Rob Herring <robh@kernel.org> writes:
> On Thu, Nov 16, 2017 at 04:51:30AM +1100, Oliver O'Halloran wrote:
...
>> diff --git a/drivers/nvdimm/of_nvdimm.c b/drivers/nvdimm/of_nvdimm.c
>> new file mode 100644
>> index 000000000000..765cbbae8bcb
>> --- /dev/null
>> +++ b/drivers/nvdimm/of_nvdimm.c
>> @@ -0,0 +1,202 @@
>> +/*
>> + * Copyright 2017, IBM Corporation
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License
>> + * along with this program; if not, you can access it online at
>> + * http://www.gnu.org/licenses/gpl-2.0.html.
>
> This can be SPDX tag.

Specifically:

// SPDX-License-Identifier: GPL-2.0+
/*
 * Copyright 2017, IBM Corporation
 */

...

cheers
