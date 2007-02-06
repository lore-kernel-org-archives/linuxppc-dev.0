Return-Path: <darwish.07@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by ozlabs.org (Postfix) with ESMTP id B0806DDE40
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Feb 2007 20:12:24 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so1887737nzf
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 06 Feb 2007 01:12:23 -0800 (PST)
Date: Tue, 6 Feb 2007 11:12:07 +0200
To: Alexey Dobriyan <adobriyan@gmail.com>
Subject: Re: [PATCH 2.6.20] ibm_emac: Use ARRAY_SIZE macro when appropriate
Message-ID: <20070206091207.GR3896@Ahmed>
References: <20070205165429.GD3896@Ahmed> <20070205165916.GK3896@Ahmed>
	<20070205202206.GD11055@martell.zuzino.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070205202206.GD11055@martell.zuzino.mipt.ru>
From: "Ahmed S. Darwish" <darwish.07@gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Feb 05, 2007 at 11:22:06PM +0300, Alexey Dobriyan wrote:
> On Mon, Feb 05, 2007 at 06:59:16PM +0200, Ahmed S. Darwish wrote:
> > A patch to use ARRAY_SIZE macro already defined in kernel.h.
> 
> OK, but checks you're changing are strange. idx there is signed so
> 
> 	BUG_ON(idx < 0 || idx > ARRAY_SIZE());
> 
> should be more appropriate.

It's just a janitor patch. I don't like to mess with code logic in such
kind of patches (to minimize errors and because I can't find time to
understand all affected files since they are scattered allover the tree).

Thanks,
-- 
Ahmed S. Darwish
http://darwish-07.blogspot.com
