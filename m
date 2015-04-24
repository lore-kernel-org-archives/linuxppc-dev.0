Return-Path: <j.anaszewski81@gmail.com>
Received: from mail-wg0-x22a.google.com (mail-wg0-x22a.google.com
 [IPv6:2a00:1450:400c:c00::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C0BB11A0DD6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 20:16:39 +1000 (AEST)
Received: by wgso17 with SMTP id o17so45627440wgs.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2015 03:16:37 -0700 (PDT)
Date: Fri, 24 Apr 2015 12:16:29 +0200
From: Jacek Anaszewski <j.anaszewski81@gmail.com>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 2/2] leds/powernv: Add driver for PowerNV platform
Message-ID: <20150424121629.69a159b3@ja.home>
In-Reply-To: <m3egnama5l.fsf@oc8180480414.ibm.com>
References: <20150422234509.626d9dc7@ja.home>
 <55388254.4000606@linux.vnet.ibm.com>
 <20150423161342.55e9ac8f@ja.home>
 <m3egnama5l.fsf@oc8180480414.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, cooloney@gmail.com, rpurdie@rpsys.net,
 linux-leds@vger.kernel.org, khandual@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 24 Apr 2015 14:18:30 +1000
Stewart Smith <stewart@linux.vnet.ibm.com> wrote:

> Jacek Anaszewski <j.anaszewski81@gmail.com> writes:
> >> These device tree comes from out firmware ... which is immutable .
> >
> > How the firmware is related to kernel? These bindings are for
> > kernel, not for the firmware.
> >
> > DT bindings are compiled to *.dtb file which is concatenated with
> > zImage. During system boot device drivers are matched with DT
> > bindings through 'compatible' property. A driver should have single
> > matching DT node, i.e. no other driver can probe with the same DT
> > node. This implies that the node should contain only the properties
> > required for configuring the related device.
> 
> For OPAL firmware on POWER, firmware hands kernel a flattened device
> tree of the machine it's booting on. It's not added to kernel as the
> kernels aren't board specific - they're generic.

Is the DT node we are discussing used by some other drivers than the
LED class driver? Or is it required in this form by other components of
your platform?

> https://github.com/open-power/skiboot/ is the firmware that generates
> the device tree for booting under OPAL.
> 


-- 
Best Regards,
Jacek Anaszewski
