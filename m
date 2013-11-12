Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wi0-x229.google.com (mail-wi0-x229.google.com
 [IPv6:2a00:1450:400c:c05::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3BC9F2C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 23:23:24 +1100 (EST)
Received: by mail-wi0-f169.google.com with SMTP id cb5so3652692wib.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Nov 2013 04:23:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131111201024.GR17929@book.gsilab.sittig.org>
References: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
 <1383290374-17484-3-git-send-email-a13xp0p0v88@gmail.com>
 <20131111201024.GR17929@book.gsilab.sittig.org>
Date: Tue, 12 Nov 2013 16:23:20 +0400
Message-ID: <CAF0T0X5mCEiS88YGGjSS6oGU5RaQ=2PEQFL533OjpQzmc398rA@mail.gmail.com>
Subject: Re: [PATCH RFC v5 2/5] dma: mpc512x: add support for peripheral
 transfers
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Gerhard Sittig <gsi@denx.de>, Dan Williams <dan.j.williams@intel.com>,
 Vinod Koul <vinod.koul@intel.com>, Lars-Peter Clausen <lars@metafoo.de>,
 Arnd Bergmann <arnd@arndb.de>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org, Alexander Popov <a13xp0p0v88@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello, Gerhard!

2013/11/12 Gerhard Sittig <gsi@denx.de>:
> Alexander, there is outstanding review feedback for a previous
> version of the series that you haven't addressed yet.  Can you
> please either look into those issues, or state that it's OK to
> leave them and why this is so?
Excuse me for misunderstanding, Gerhard.
I have thoroughly worked on your feedback to RFCv4
and agreed to your points. So I've just wrote RFCv5.
And all the improvements and known issues based on your feedback
are listed in the cover letter [PATCH RFC v5 0/5].

> It would be nice to get a
> response to the feedback that you are given.  It may be
> appropriate not to obey to the feedback, but at least it should
> get considered.
Yes, I see. My implicit response by RFCv5 was not efficient, sorry.
Now should I write a detailed answer in the thread with your feedback
for improving readability of the discussion?

> Have you noticed the recent introduction of the dmaengine@vger
> ML?
No, I didn't.

>Make sure to include it upon the next submission.
Ok, I will.

Thanks.

Best regards,
Alexander.
