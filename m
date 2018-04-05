Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40H5DC6swLzF1kQ
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 00:43:22 +1000 (AEST)
Received: by mail-ot0-x241.google.com with SMTP id p33-v6so21155747otp.11
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Apr 2018 07:43:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAOSf1CEUnucUhW_pXG=7h5QBHvaH2-ENPKjGD42_0WEvbU6-Wg@mail.gmail.com>
References: <20180403142415.30083-1-oohall@gmail.com>
 <20180403142415.30083-3-oohall@gmail.com>
 <CAPcyv4jW5H8A96MFD7-UazNSZq-t1_NfrChNB3p9=somdBpsNw@mail.gmail.com>
 <20180404220750.0436bbe1@gmail.com>
 <CAOSf1CGdKU4zQQauqo3UoNvKnKDMHteAEtsMWVtTG7T01csMbg@mail.gmail.com>
 <CAPcyv4if4un9mgFon4ttjKDYEtHC_GP6VoxUENp7YNS50T3afA@mail.gmail.com>
 <CAOSf1CHu4R-t8q-8fL6Dyk7myFR0gTfd6-0cxqtBVGZgYZWGAw@mail.gmail.com>
 <87bmexua3s.fsf@concordia.ellerman.id.au>
 <CAOSf1CEUnucUhW_pXG=7h5QBHvaH2-ENPKjGD42_0WEvbU6-Wg@mail.gmail.com>
From: Dan Williams <dan.j.williams@intel.com>
Date: Thu, 5 Apr 2018 07:43:20 -0700
Message-ID: <CAPcyv4jEFMnYqpcop=Ox-dZR3dSBRMhT05JSS-gPABX_YQGw1g@mail.gmail.com>
Subject: Re: [RESEND v2 3/4] doc/devicetree: Persistent memory region bindings
To: Oliver <oohall@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Device Tree <devicetree@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-nvdimm <linux-nvdimm@lists.01.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 5, 2018 at 5:43 AM, Oliver <oohall@gmail.com> wrote:
> On Thu, Apr 5, 2018 at 10:11 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> Oliver <oohall@gmail.com> writes:
>> ...
>>>
>>> For context Balbir is working with me on some of the pmem stuff. You
>>> probably want an Ack from Rob rather than one of us.
>>
>> I'll ack it if you make all the niggly nit picky trivial annoying
>> changes I asked for :D
>
> *groan*
>
> Fine, I'll respin it tomorrow. If anyone else has comments now would
> be the time to make them.

Please also include my niggly nit picky trivial annoying bike shed
color for the driver name to *not* use the "nd_region" suffix for a
driver registering "nvdimm_bus" objects. "of_pmem_range" or
"of_pmem_bus" or almost anything else would be fine.
