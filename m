Return-Path: <gang.chen@asianux.com>
Received: from intranet.asianux.com (intranet.asianux.com [58.214.24.6])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1C9B42C03EF
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 12:29:36 +1100 (EST)
Message-ID: <527303B4.2030301@asianux.com>
Date: Fri, 01 Nov 2013 09:28:20 +0800
From: Chen Gang <gang.chen@asianux.com>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [Suggestion] drivers: powercap: 'dev_attrs' has already removed
 from 'struct class'
References: <5271BDFD.2050205@asianux.com> <52728461.2080901@intel.com>
In-Reply-To: <52728461.2080901@intel.com>
Content-Type: text/plain; charset=UTF-8
Cc: Greg KH <gregkh@linuxfoundation.org>, jacob.jun.pan@linux.intel.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 srinivas.pandruvada@linux.intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/01/2013 12:25 AM, Rafael J. Wysocki wrote:
> On 10/31/2013 3:18 AM, Chen Gang wrote:
>> Hello Maintainers
>>
>> It is removed by "bcc8edb driver core: remove dev_attrs from struct
>> class" in Oct 5 2013. But "75d2364 PowerCap: Add class driver" still
>> use it in Oct 11 2013.
>>
>> The related error (for powerpc with allmodconfig):
>>
>>    CC      drivers/powercap/powercap_sys.o
>> drivers/powercap/powercap_sys.c:484:2: error: unknown field
>> �dev_attrs� specified in initializer
>> drivers/powercap/powercap_sys.c:484:2: warning: initialization from
>> incompatible pointer type [enabled by default]
>> drivers/powercap/powercap_sys.c:484:2: warning: (near initialization
>> for �powercap_class.suspend�) [enabled by default]
>>
>>
>> Please give a check thanks.
> 
> That should have been fixed in the current linux-next already.
> 

OK, thanks.

> Thanks,
> Rafael
> 
> 
> 


-- 
Chen Gang
