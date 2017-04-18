Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6ZvS013rzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 16:28:19 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Cc: Christophe Lombard <clombard@linux.vnet.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 Uma Krishnan <ukrishn@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cxl: Enable PCI device IDs for future IBM CXL adapters
In-Reply-To: <8639654F-B890-4CA4-ACF2-8A5DFDC3F75B@linux.vnet.ibm.com>
References: <1490371400-33398-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <8639654F-B890-4CA4-ACF2-8A5DFDC3F75B@linux.vnet.ibm.com>
Date: Tue, 18 Apr 2017 16:28:19 +1000
Message-ID: <87poga6xh8.fsf@concordia.ellerman.id.au>
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

"Matthew R. Ochs" <mrochs@linux.vnet.ibm.com> writes:

>> On Mar 24, 2017, at 11:03 AM, Matthew R. Ochs <mrochs@linux.vnet.ibm.com> wrote:
>> 
>> Add support for future IBM Coherent Accelerator (CXL) devices
>> with an IDs of 0x0623 and 0x0628.
>> 
>> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
>> Acked-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>
> Hi Michael,
>
> I think this one might have been overlooked. We'd like to try and
> get this in for 4.12 to match up with our 4-port series in cxlflash.

I saw it, but hadn't got around to actually applying it.

Have just put it in.

cheers
