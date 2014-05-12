Return-Path: <groeck7@gmail.com>
Received: from mail-pa0-x234.google.com (mail-pa0-x234.google.com
 [IPv6:2607:f8b0:400e:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7D324140086
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 May 2014 01:54:03 +1000 (EST)
Received: by mail-pa0-f52.google.com with SMTP id fa1so4781225pad.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 May 2014 08:54:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Mon, 12 May 2014 08:53:49 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix "attempt to move .org backwards" error
 (again)
Message-ID: <20140512155349.GA29066@roeck-us.net>
References: <1399680478-4970-1-git-send-email-linux@roeck-us.net>
 <1399867920.17624.73.camel@pasglop> <5370537F.8020901@roeck-us.net>
 <1399873724.17624.80.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1399873724.17624.80.camel@pasglop>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 12, 2014 at 03:48:44PM +1000, Benjamin Herrenschmidt wrote:
> On Sun, 2014-05-11 at 21:52 -0700, Guenter Roeck wrote:
> > Oh well, it was worth a try. Can you give me an example for a failing
> > configuration ?
> 
> My g5 config which is close to g5_defconfig with PR KVM enabled.
> 
> In any case, see my other messages. I'm waiting for all my test builders
> to come back and if it's clear I'll post a new patch.
> 
I'll be more than happy to wait. Let me know if I can test something.

Thanks,
Guenter
