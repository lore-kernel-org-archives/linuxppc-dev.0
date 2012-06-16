Return-Path: <gregkh@linuxfoundation.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
 [209.85.210.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 347F1B70D4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jun 2012 11:47:38 +1000 (EST)
Received: by dajt11 with SMTP id t11so5210084daj.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jun 2012 18:47:36 -0700 (PDT)
Date: Fri, 15 Jun 2012 18:47:32 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Fengguang Wu <wfg@linux.intel.com>
Subject: Re: [driver-core:driver-core-linus 6/6]
 drivers/firmware/iscsi_ibft_find.o: In function `kmsg_dump_rewind':
 (.text+0x18): multiple definition of `kmsg_dump_rewind'
Message-ID: <20120616014732.GA2981@kroah.com>
References: <4fdbcd2f.Ta8kRp58FRzqrqaL%wfg@linux.intel.com>
 <20120616011646.GA7847@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20120616011646.GA7847@localhost>
Cc: devel@driverdev.osuosl.org, linux-mtd@lists.infradead.org,
 Kay Sievers <kay@vrfy.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 16, 2012 at 09:16:46AM +0800, Fengguang Wu wrote:
> Hi list,
> 
> I'm sorry if this pile of build errors disturbed you too much. If
> the error notification is too permissive, I can limit it in two ways:
> 
> 1) only notify build errors on the first kconfig. There may be a few
>    new error messages show up in the other kconfig builds, however
>    mostly are just irritating duplications.

Duplicates should be suppressed, they are just annoying.

> 2) only notify the mailing list directly associated with the git tree.
>    In this particular case, to only CC devel@driverdev.osuosl.org, and
>    to avoid the linux-mtd and linuxppc-dev lists.

Yes, that would be the best thing to do to start with, then let the
developers take it from there.

thanks,

greg k-h
