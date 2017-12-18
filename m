Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z0tP43j4zzDrmy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 07:46:32 +1100 (AEDT)
Subject: Re: ps3: Improve a size determination in five functions
To: Geoff Levand <geoff@infradead.org>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <9b6464bc-a408-de2a-1b54-cb7794b92506@users.sourceforge.net>
 <7aed1208-aa55-edb6-54be-f47fb1498bfd@users.sourceforge.net>
 <128a40fe-0998-2d6c-ad56-e7b63fce7f12@infradead.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Message-ID: <37ac8110-057a-9f07-841c-03e49d48f317@users.sourceforge.net>
Date: Mon, 18 Dec 2017 21:45:33 +0100
MIME-Version: 1.0
In-Reply-To: <128a40fe-0998-2d6c-ad56-e7b63fce7f12@infradead.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> Replace the specification of data structures by variable references
>> as the parameter for the operator "sizeof" to make the corresponding size
>> determination a bit safer according to the Linux coding style convention.
> 
> This would be OK,

Thanks.


> but you are also removing empty lines and changing the coding format.

* Why do you not like such a change combination?

* Do you really want to integrate further update steps in this case?

Regards,
Markus
