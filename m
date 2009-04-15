Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 533D8DE098
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Apr 2009 08:31:44 +1000 (EST)
Date: Wed, 15 Apr 2009 15:26:35 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Harry Ciao <qingtao.cao@windriver.com>
Subject: Re: [v2 PATCH 0/3] Add CPC925 Memory Controller EDAC drivers
Message-Id: <20090415152635.2e1e260a.akpm@linux-foundation.org>
In-Reply-To: <1239602716-18352-1-git-send-email-qingtao.cao@windriver.com>
References: <1239602716-18352-1-git-send-email-qingtao.cao@windriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: norsk5@yahoo.com, bluesmoke-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 13 Apr 2009 14:05:13 +0800
Harry Ciao <qingtao.cao@windriver.com> wrote:

> 
> Hi Doug and Michael,
> 
> This is the latest v2 patches, the 1/3 of CPC925 MC EDAC driver remains
> the same as before, the 2/3 has been pushed to Andrew already, and the 
> 3/3 has integrated Michael's suggestions to add a fixup routine for the 
> memory controller on Maple that has incorrect number of cells, and create
> related platform_device for CPC925 on Motorola ATCA-6101 target by far.
> 
> All patches have been tested, please give me your further concerns or 
> suggestions, thanks!

For some reason I didn't have 2/3 anywhere.

I'll plan to merge all these into 2.6.31 unless someone shouts at me.
