Return-Path: <fbarrat@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zSj571XN5zF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Jan 2018 02:10:19 +1100 (AEDT)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w0QF9tY8127620
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 10:10:16 -0500
Received: from e06smtp14.uk.ibm.com (e06smtp14.uk.ibm.com [195.75.94.110])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2fr4thd0mw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jan 2018 10:10:15 -0500
Received: from localhost
 by e06smtp14.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <fbarrat@linux.vnet.ibm.com>;
 Fri, 26 Jan 2018 15:10:13 -0000
Subject: Re: [PATCH v2 12/13] ocxl: Documentation
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de,
 mpe@ellerman.id.au, andrew.donnellan@au1.ibm.com, alastair@au1.ibm.com
References: <20180123113148.6024-1-fbarrat@linux.vnet.ibm.com>
 <20180123113148.6024-13-fbarrat@linux.vnet.ibm.com>
 <20180125131748.GB8576@kroah.com>
From: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
Date: Fri, 26 Jan 2018 16:10:08 +0100
MIME-Version: 1.0
In-Reply-To: <20180125131748.GB8576@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <f457e877-11f8-d89c-dce1-34642c1c9318@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 25/01/2018 à 14:17, Greg KH a écrit :
> On Tue, Jan 23, 2018 at 12:31:47PM +0100, Frederic Barrat wrote:
>> ocxl.rst gives a quick, high-level view of opencapi.
>>
>> Update ioctl-number.txt to reflect ioctl numbers being used by the
>> ocxl driver
>>
>> Signed-off-by: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
>> ---
>>   Documentation/ABI/testing/sysfs-class-ocxl |  35 +++++++
>>   Documentation/accelerators/ocxl.rst        | 160 +++++++++++++++++++++++++++++
>>   Documentation/ioctl/ioctl-number.txt       |   1 +
>>   3 files changed, 196 insertions(+)
>>   create mode 100644 Documentation/ABI/testing/sysfs-class-ocxl
>>   create mode 100644 Documentation/accelerators/ocxl.rst
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-ocxl b/Documentation/ABI/testing/sysfs-class-ocxl
>> new file mode 100644
>> index 000000000000..ac11deb71235
>> --- /dev/null
>> +++ b/Documentation/ABI/testing/sysfs-class-ocxl
>> @@ -0,0 +1,35 @@
>> +What:           /sys/class/ocxl/<afu name>/afu_version
>> +Date:           January 2018
>> +Contact:        linuxppc-dev@lists.ozlabs.org
>> +Description:    read only
>> +                Version of the AFU, in the format <major>:<minor>
>> +		Reflects what is read in the configuration space of the AFU
> 
> Odd mix of tabs and spaces in this file, please just use tabs.

Oops! Will fix.

   Fred


> thanks,
> 
> greg k-h
> 
