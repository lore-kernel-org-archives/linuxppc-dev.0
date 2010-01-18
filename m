Return-Path: <glikely@secretlab.ca>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id BF160B7C63
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jan 2010 04:36:36 +1100 (EST)
Received: by yxe8 with SMTP id 8so1004014yxe.17
	for <linuxppc-dev@ozlabs.org>; Mon, 18 Jan 2010 09:36:34 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <4B4DE58D.10008@petalogix.com>
References: <4B4DE58D.10008@petalogix.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 18 Jan 2010 10:36:07 -0700
Message-ID: <fa686aa41001180936p1fd34dd4pdf675583ce5ccd86@mail.gmail.com>
Subject: Re: xilinx-pci driver and pci in general
To: michal.simek@petalogix.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, thunderbird2k@gmx.net,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 13, 2010 at 8:23 AM, Michal Simek
<michal.simek@petalogix.com> wrote:
> Hi guys,
>
> We (John and partially I) did initial support for pci on Microblaze.
> It is based on powerpc files and almost everything is the same.
> There are some small differences which could be easily removed that's why I
> think that will be good to move that file to any generic location.
> That's why I would like to know your opinion about this step.
> If you don't like or prefer we will add that modified versions to
> arch/microblaze and in future we can merge them and move to any other
> location.
>
> Affected files: xilinx-pci.c, pci_32.c pci-common.c, indirect_pci.c and some
> headers.

My preference is to move the common bits to a common location first,
and then modify to make it suitable for Microblaze also.  I've just
finished doing a bunch of fdt merge work where PowerPC and Microblaze
diverged in subtle ways.  It isn't a whole lot of fun.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
