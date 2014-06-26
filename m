Return-Path: <sudeep.holla@arm.com>
Received: from service88.mimecast.com (service88.mimecast.com [195.130.217.12])
 by lists.ozlabs.org (Postfix) with ESMTP id E38601A0013
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jun 2014 04:47:21 +1000 (EST)
Message-ID: <53AC695C.2090406@arm.com>
Date: Thu, 26 Jun 2014 19:41:32 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 2/9] drivers: base: support cpu cache information interface
 to userspace via sysfs
References: <1403717444-23559-1-git-send-email-sudeep.holla@arm.com>
 <1403717444-23559-3-git-send-email-sudeep.holla@arm.com>
 <20140625222355.GK32514@n2100.arm.linux.org.uk>
In-Reply-To: <20140625222355.GK32514@n2100.arm.linux.org.uk>
Content-Type: text/plain; charset=WINDOWS-1252; format=flowed
Cc: Rob Herring <robh@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 Heiko Carstens <heiko.carstens@de.ibm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Sudeep Holla <sudeep.holla@arm.com>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>, "x86@kernel.org" <x86@kernel.org>,
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

Hi,

On 25/06/14 23:23, Russell King - ARM Linux wrote:
> On Wed, Jun 25, 2014 at 06:30:37PM +0100, Sudeep Holla wrote:
>> +=09=09coherency_line_size: the minimum amount of data that gets transfe=
rred
>
> So, what value to do envision this taking for a CPU where the cache
> line size is 32 bytes, but each cache line has two dirty bits which
> allow it to only evict either the upper or lower 16 bytes depending
> on which are dirty?
>

IIUC most of existing implementations of cacheinfo on various architectures
are representing the cache line size as coherency_line_size, in which case =
I
need fix the definition in this file.

BTW will there be any architectural way of finding such configuration ?

Regards,
Sudeep
