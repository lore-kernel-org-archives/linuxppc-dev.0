Return-Path: <pku.leo@gmail.com>
Received: from mail-qy0-f187.google.com (mail-qy0-f187.google.com
	[209.85.221.187]) by ozlabs.org (Postfix) with ESMTP id 27909B7D0F
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Apr 2010 16:46:44 +1000 (EST)
Received: by qyk17 with SMTP id 17so3156897qyk.9
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Apr 2010 23:46:42 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <1271645181.14835.46.camel@concordia>
References: <1271403278-30091-1-git-send-email-leoli@freescale.com>
	<1271403278-30091-2-git-send-email-leoli@freescale.com>
	<1271645181.14835.46.camel@concordia>
Date: Mon, 19 Apr 2010 14:46:42 +0800
Message-ID: <m2o2a27d3731004182346z39532609o1ad03cc92aa1a50f@mail.gmail.com>
Subject: Re: [PATCH 2/4] fsl_msi: enable msi allocation in all banks
From: Li Yang <leoli@freescale.com>
To: michael@ellerman.id.au
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Zhao Chenhui <b26998@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Apr 19, 2010 at 10:46 AM, Michael Ellerman
<michael@ellerman.id.au> wrote:
> On Fri, 2010-04-16 at 15:34 +0800, Li Yang wrote:
>> From: Zhao Chenhui <b26998@freescale.com>
>>
>> Put all fsl_msi banks in a linked list. The list of banks then can be
>> traversed when allocating new msi interrupts.
>
> So there are multiple banks, and you just use the first one that has an
> empty slot in it's bitmap?

Yes, currently we are.  What allocation algorithm do you think is
better?  I don't think spreading the allocation evenly should have any
performance benefit.  The point of multiple banks should be better
insulation through multiple OS's, IMHO.

- Leo
