Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zT8sm6GrjzDqvk
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 20:02:04 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Greg KH <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
Subject: Re: [PATCH v2 12/13] ocxl: Documentation
In-Reply-To: <f457e877-11f8-d89c-dce1-34642c1c9318@linux.vnet.ibm.com>
References: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
 <20180123113148.6024-13-fbarrat@linux.vnet.ibm.com>
 <20180125131748.GB8576@kroah.com>
 <f457e877-11f8-d89c-dce1-34642c1c9318@linux.vnet.ibm.com>
Date: Sat, 27 Jan 2018 20:02:04 +1100
Message-ID: <87mv0z3cab.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Frederic Barrat <fbarrat@linux.vnet.ibm.com> writes:

> Le 25/01/2018 =C3=A0 14:17, Greg KH a =C3=A9crit=C2=A0:
>> On Tue, Jan 23, 2018 at 12:31:47PM +0100, Frederic Barrat wrote:
>>> ocxl.rst gives a quick, high-level view of opencapi.
>>>
>>> Update ioctl-number.txt to reflect ioctl numbers being used by the
>>> ocxl driver
>>>
>>> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>>> ---
>>>   Documentation/ABI/testing/sysfs-class-ocxl |  35 +++++++
>>>   Documentation/accelerators/ocxl.rst        | 160 ++++++++++++++++++++=
+++++++++
>>>   Documentation/ioctl/ioctl-number.txt       |   1 +
>>>   3 files changed, 196 insertions(+)
>>>   create mode 100644 Documentation/ABI/testing/sysfs-class-ocxl
>>>   create mode 100644 Documentation/accelerators/ocxl.rst
>>>
>>> diff --git a/Documentation/ABI/testing/sysfs-class-ocxl b/Documentation=
/ABI/testing/sysfs-class-ocxl
>>> new file mode 100644
>>> index 000000000000..ac11deb71235
>>> --- /dev/null
>>> +++ b/Documentation/ABI/testing/sysfs-class-ocxl
>>> @@ -0,0 +1,35 @@
>>> +What:           /sys/class/ocxl/<afu name>/afu_version
>>> +Date:           January 2018
>>> +Contact:        linuxppc-dev@lists.ozlabs.org
>>> +Description:    read only
>>> +                Version of the AFU, in the format <major>:<minor>
>>> +		Reflects what is read in the configuration space of the AFU
>>=20
>> Odd mix of tabs and spaces in this file, please just use tabs.
>
> Oops! Will fix.

I've already applied it to my test tree, I'll fix it up.

cheers
