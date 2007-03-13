Return-Path: <glikely@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id 73CC4DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 01:00:25 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id m18so2280403nfc
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 07:00:23 -0700 (PDT)
Message-ID: <528646bc0703130700o4773f0c6g460cc2d53ea90da9@mail.gmail.com>
Date: Tue, 13 Mar 2007 08:00:09 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@gmail.com
To: "Christoph Hellwig" <hch@lst.de>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
In-Reply-To: <20070313094229.GA13567@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200703122254.27087.sr@denx.de> <20070313094229.GA13567@lst.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 3/13/07, Christoph Hellwig <hch@lst.de> wrote:
> On Mon, Mar 12, 2007 at 10:54:26PM +0100, Stefan Roese wrote:
> >  arch/ppc/Kconfig               |   10 ++++++++
> >  arch/ppc/kernel/head_44x.S     |   23 ++++++++++---------
> >  arch/ppc/kernel/misc.S         |   13 ++++++-----
> >  arch/ppc/kernel/vmlinux.lds.S  |   15 +++++++-----
> >  include/asm-ppc/page.h         |    6 ++++-
> >  include/asm-ppc/ppc_page_asm.h |   49 ++++++++++++++++++++++++++++++++++++++++
>
> I though we'd given up on arch/ppc by now?
> Can you try to redo this over the arch/powerpc/ 44x port?

Not dead yet.  arch/powerpc support is not complete for 4xx cores and
older bootloaders cannot boot arch/powerpc kernels yet.

g.

-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
