Return-Path: <rafael.j.wysocki@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id C89D32C03DB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Nov 2013 03:25:11 +1100 (EST)
Message-ID: <52728461.2080901@intel.com>
Date: Thu, 31 Oct 2013 17:25:05 +0100
From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>,
 srinivas.pandruvada@linux.intel.com, jacob.jun.pan@linux.intel.com,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [Suggestion] drivers: powercap: 'dev_attrs' has already removed
 from 'struct class'
References: <5271BDFD.2050205@asianux.com>
In-Reply-To: <5271BDFD.2050205@asianux.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Greg KH <gregkh@linuxfoundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/31/2013 3:18 AM, Chen Gang wrote:
> Hello Maintainers
>
> It is removed by "bcc8edb driver core: remove dev_attrs from struct
> class" in Oct 5 2013. But "75d2364 PowerCap: Add class driver" still
> use it in Oct 11 2013.
>
> The related error (for powerpc with allmodconfig):
>
>    CC      drivers/powercap/powercap_sys.o
> drivers/powercap/powercap_sys.c:484:2: error: unknown field ‘dev_attrs’ specified in initializer
> drivers/powercap/powercap_sys.c:484:2: warning: initialization from incompatible pointer type [enabled by default]
> drivers/powercap/powercap_sys.c:484:2: warning: (near initialization for ‘powercap_class.suspend’) [enabled by default]
>
>
> Please give a check thanks.

That should have been fixed in the current linux-next already.

Thanks,
Rafael
