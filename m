Return-Path: <sudeep.holla@arm.com>
Received: from service87.mimecast.com (service87.mimecast.com [91.220.42.44])
 by lists.ozlabs.org (Postfix) with ESMTP id 273471A0771
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Sep 2014 18:54:58 +1000 (EST)
Message-ID: <541FE3F6.4070806@arm.com>
Date: Mon, 22 Sep 2014 09:55:18 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Stephen Boyd <sboyd@codeaurora.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/11] drivers: base: support cpu cache information
 interface to userspace via sysfs
References: <1409763617-17074-1-git-send-email-sudeep.holla@arm.com>
 <1409763617-17074-5-git-send-email-sudeep.holla@arm.com>
 <541CAD16.6030309@codeaurora.org>
In-Reply-To: <541CAD16.6030309@codeaurora.org>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Stephen,

On 19/09/14 23:24, Stephen Boyd wrote:
> On 09/03/14 10:00, Sudeep Holla wrote:
>> From: Sudeep Holla <sudeep.holla@arm.com>
>>
>> This patch adds initial support for providing processor cache informatio=
n
>> to userspace through sysfs interface. This is based on already existing
>> implementations(x86, ia64, s390 and powerpc) and hence the interface is
>> intended to be fully compatible.
>>
>> The main purpose of this generic support is to avoid further code
>> duplication to support new architectures and also to unify all the exist=
ing
>> different implementations.
>>
>> This implementation maintains the hierarchy of cache objects which refle=
cts
>> the system's cache topology. Cache devices are instantiated as needed as
>> CPUs come online. The cache information is replicated per-cpu even if th=
ey are
>> shared. A per-cpu array of cache information maintained is used mainly f=
or
>> sysfs-related book keeping.
>>
>> It also implements the shared_cpu_map attribute, which is essential for
>> enabling both kernel and user-space to discover the system's overall cac=
he
>> topology.
>>
>> This patch also add the missing ABI documentation for the cacheinfo sysf=
s
>> interface already, which is well defined and widely used.
>>
>> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Stephen Boyd <sboyd@codeaurora.org>
>> Cc: linux-api@vger.kernel.org
>> Cc: linux390@de.ibm.com
>> Cc: linux-arm-kernel@lists.infradead.org
>> Cc: linux-ia64@vger.kernel.org
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Cc: linux-s390@vger.kernel.org
>> Cc: x86@kernel.org
>>
>
> Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
> Tested-by: Stephen Boyd <sboyd@codeaurora.org>
>

Thanks for all the reviews and testings of the series.

Regards,
Sudeep
