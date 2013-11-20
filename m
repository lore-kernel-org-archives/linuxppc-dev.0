Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wi0-x22a.google.com (mail-wi0-x22a.google.com
 [IPv6:2a00:1450:400c:c05::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 478C92C009A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Nov 2013 17:49:13 +1100 (EST)
Received: by mail-wi0-f170.google.com with SMTP id f4so7642182wiw.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 22:49:08 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20131114205810.GH17929@book.gsilab.sittig.org>
References: <1383290374-17484-1-git-send-email-a13xp0p0v88@gmail.com>
 <1383290374-17484-3-git-send-email-a13xp0p0v88@gmail.com>
 <20131111201024.GR17929@book.gsilab.sittig.org>
 <CAF0T0X5mCEiS88YGGjSS6oGU5RaQ=2PEQFL533OjpQzmc398rA@mail.gmail.com>
 <20131114205810.GH17929@book.gsilab.sittig.org>
Date: Wed, 20 Nov 2013 10:49:08 +0400
Message-ID: <CAF0T0X6c9101zbp3kofjLOQDpFdutDJQ+ciHiCcRnCV_sxn4uQ@mail.gmail.com>
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

2013/11/15 Gerhard Sittig <gsi@denx.de>:
> As for the not yet addressed feedback:  From the top of my head I
> can think of the execute comment which contradicts the code
> (which suggests that at least one of them is wrong), and the data
> type mismatch in the config routine (where code just happens to
> work by coincidence).  And in bypassing I noticed that your
> recent submission has coding style issues (braces, indentation),
> which should no longer happen after several iterations as you
> should know how to prepare and check the next version.
I'll doublecheck this and return with improved code.

> Without feedback, reviewers
> may see several submissions which suffer from the same issues,
> and expect more to show up and thus feel that their feedback is
> getting ignored.  Which quickly becomes tiring.
Thanks for your patience and comprehensive replies.

Best regards,
Alexander.
