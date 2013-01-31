Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.19.201])
 by ozlabs.org (Postfix) with ESMTP id E762E2C0296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 16:22:54 +1100 (EST)
Date: Thu, 31 Jan 2013 06:24:48 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Toshi Kani <toshi.kani@hp.com>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device hotplug
 framework
Message-ID: <20130131052448.GC3228@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <5036592.TuXAnGzk4M@vostro.rjw.lan>
 <1358177628.14145.49.camel@misato.fc.hp.com>
 <2154272.qDAyBlTr8z@vostro.rjw.lan>
 <1358190124.14145.79.camel@misato.fc.hp.com>
 <20130130044859.GD30002@kroah.com>
 <1359594912.15120.85.camel@misato.fc.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1359594912.15120.85.camel@misato.fc.hp.com>
Cc: linux-s390@vger.kernel.org, jiang.liu@huawei.com, wency@cn.fujitsu.com,
 linux-mm@kvack.org, yinghai@kernel.org, linux-kernel@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@sisk.pl>, linux-acpi@vger.kernel.org,
 isimatu.yasuaki@jp.fujitsu.com, srivatsa.bhat@linux.vnet.ibm.com,
 guohanjun@huawei.com, bhelgaas@google.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 30, 2013 at 06:15:12PM -0700, Toshi Kani wrote:
> > Please make it a "real" pointer, and not a void *, those shouldn't be
> > used at all if possible.
> 
> How about changing the "void *handle" to acpi_dev_node below?   
> 
>    struct acpi_dev_node    acpi_node;
> 
> Basically, it has the same challenge as struct device, which uses
> acpi_dev_node as well.  We can add other FW node when needed (just like
> device also has *of_node).

That sounds good to me.
