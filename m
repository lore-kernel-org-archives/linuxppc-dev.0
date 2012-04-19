Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pz0-f42.google.com (mail-pz0-f42.google.com
 [209.85.210.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 01CA3B6FEB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2012 01:29:00 +1000 (EST)
Received: by dang27 with SMTP id g27so12768925dan.15
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Apr 2012 08:28:57 -0700 (PDT)
Date: Thu, 19 Apr 2012 08:28:51 -0700
From: Greg K H <gregkh@linuxfoundation.org>
To: Mauro Carvalho Chehab <mchehab@redhat.com>
Subject: Re: [PATCH] edac: change the mem allocation scheme to make
 Documentation/kobject.txt happy
Message-ID: <20120419152851.GD31543@kroah.com>
References: <1334697467.3920.5.camel@joe2Laptop>
 <1334841690-305-1-git-send-email-mchehab@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1334841690-305-1-git-send-email-mchehab@redhat.com>
Cc: "Arvind R." <arvino55@gmail.com>, Michal Marek <mmarek@suse.cz>,
 linuxppc-dev@lists.ozlabs.org, Mark Gross <mark.gross@intel.com>,
 Shaohui Xie <Shaohui.Xie@freescale.com>,
 Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Jiri Kosina <jkosina@suse.cz>,
 Ranganathan Desikan <ravi@jetztechnologies.com>,
 Borislav Petkov <borislav.petkov@amd.com>, Chris Metcalf <cmetcalf@tilera.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Egor Martovetsky <egor@pasemi.com>, Aristeu Rozanski <arozansk@redhat.com>,
 Olof Johansson <olof@lixom.net>, Doug Thompson <norsk5@yahoo.com>,
 Andrew Morton <akpm@linux-foundation.org>, Tim Small <tim@buttersideup.com>,
 Hitoshi Mitake <h.mitake@gmail.com>,
 Linux Edac Mailing List <linux-edac@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 19, 2012 at 10:21:30AM -0300, Mauro Carvalho Chehab wrote:
> Kernel kobjects have rigid rules: each container object should be
> dynamically allocated, and can't be allocated into a single kmalloc.
> 
> EDAC never obeyed this rule: it has a single malloc function that
> allocates all needed data into a single kzalloc.
> 
> As this is not accepted anymore, change the allocation schema of the
> EDAC *_info structs to enforce this Kernel standard.

Very nice work, thanks for doing this:
	Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
