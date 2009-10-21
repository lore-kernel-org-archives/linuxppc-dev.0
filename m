Return-Path: <glikely@secretlab.ca>
Received: from mail-gx0-f228.google.com (mail-gx0-f228.google.com
	[209.85.217.228]) by ozlabs.org (Postfix) with ESMTP id 452D5B7BE6
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2009 01:45:26 +1100 (EST)
Received: by gxk28 with SMTP id 28so6017282gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Oct 2009 07:45:25 -0700 (PDT)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20091021131747.GG12819@pengutronix.de>
References: <20090618025030.12363.69402.stgit@localhost.localdomain>
	<20091021131747.GG12819@pengutronix.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 21 Oct 2009 23:45:05 +0900
Message-ID: <fa686aa40910210745l7d19d6ecq303ee990bed82c62@mail.gmail.com>
Subject: Re: [PATCH v4] powerpc/5200: Add mpc5200-spi (non-PSC) device driver
To: Wolfram Sang <w.sang@pengutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2009 at 10:17 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Hi Grant,
>
> On Wed, Jun 17, 2009 at 08:55:01PM -0600, Grant Likely wrote:
>> From: Grant Likely <grant.likely@secretlab.ca>
>>
>> Adds support for the dedicated SPI device on the Freescale MPC5200(b)
>> SoC.
>>
>> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>
> do you have an updated version to share? Or is V4 still 'status quo'?

V4 was supposed to go in during the merge window.  But I haven't heard
anything from David (and I didn't pursue it either).  Unless David
objects, I'll put it into either my -merge or my -next tree; depending
on what Ben and Linus prefer.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
