Return-Path: <adobriyan@gmail.com>
Received: from mail-fx0-f222.google.com (mail-fx0-f222.google.com
	[209.85.220.222]) by ozlabs.org (Postfix) with ESMTP id 2E2D51007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Jan 2010 04:41:31 +1100 (EST)
Received: by fxm22 with SMTP id 22so26991784fxm.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 09:41:27 -0800 (PST)
Date: Tue, 12 Jan 2010 19:41:25 +0200
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] proc_devtree: fix THIS_MODULE without module.h
Message-ID: <20100112174125.GA4260@x200>
References: <1262830753.577814.127040702434.1.gpush@pororo>
	<20100109110104.GA20100@x200>
	<fa686aa41001111458g5975e055ga4c7cd830fff1906@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa41001111458g5975e055ga4c7cd830fff1906@mail.gmail.com>
Cc: Jeremy Kerr <jeremy.kerr@canonical.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 11, 2010 at 03:58:47PM -0700, Grant Likely wrote:
> On Sat, Jan 9, 2010 at 4:01 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > I'd say, remove .owner line.
> > It definitely not needed in non-modular code.
> 
> No.  Jeremy's fix is the better one.  Having the .owner line doesn't
> cost anything and it is better to have it populated; even if only as
> an example.

Core proc code doesn't use it anymore.
