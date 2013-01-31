Return-Path: <toshi.kani@hp.com>
Received: from g1t0027.austin.hp.com (g1t0027.austin.hp.com [15.216.28.34])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "smtp.hp.com",
 Issuer "VeriSign Class 3 Secure Server CA - G3" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 332012C008D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Feb 2013 01:52:48 +1100 (EST)
Message-ID: <1359643356.15120.158.camel@misato.fc.hp.com>
Subject: Re: [RFC PATCH v2 01/12] Add sys_hotplug.h for system device
 hotplug framework
From: Toshi Kani <toshi.kani@hp.com>
To: Greg KH <gregkh@linuxfoundation.org>
Date: Thu, 31 Jan 2013 07:42:36 -0700
In-Reply-To: <20130131052448.GC3228@kroah.com>
References: <1357861230-29549-1-git-send-email-toshi.kani@hp.com>
 <5036592.TuXAnGzk4M@vostro.rjw.lan>
 <1358177628.14145.49.camel@misato.fc.hp.com>
 <2154272.qDAyBlTr8z@vostro.rjw.lan>
 <1358190124.14145.79.camel@misato.fc.hp.com>
 <20130130044859.GD30002@kroah.com>
 <1359594912.15120.85.camel@misato.fc.hp.com>
 <20130131052448.GC3228@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "jiang.liu@huawei.com" <jiang.liu@huawei.com>,
 "wency@cn.fujitsu.com" <wency@cn.fujitsu.com>,
 "linux-mm@kvack.org" <linux-mm@kvack.org>,
 "yinghai@kernel.org" <yinghai@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>,
 "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
 "isimatu.yasuaki@jp.fujitsu.com" <isimatu.yasuaki@jp.fujitsu.com>,
 "srivatsa.bhat@linux.vnet.ibm.com" <srivatsa.bhat@linux.vnet.ibm.com>,
 "guohanjun@huawei.com" <guohanjun@huawei.com>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "lenb@kernel.org" <lenb@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-01-31 at 05:24 +0000, Greg KH wrote:
> On Wed, Jan 30, 2013 at 06:15:12PM -0700, Toshi Kani wrote:
> > > Please make it a "real" pointer, and not a void *, those shouldn't be
> > > used at all if possible.
> > 
> > How about changing the "void *handle" to acpi_dev_node below?   
> > 
> >    struct acpi_dev_node    acpi_node;
> > 
> > Basically, it has the same challenge as struct device, which uses
> > acpi_dev_node as well.  We can add other FW node when needed (just like
> > device also has *of_node).
> 
> That sounds good to me.

Great!  Thanks Greg,
-Toshi
