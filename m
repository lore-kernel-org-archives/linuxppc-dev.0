Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id F2381DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 10:07:17 +1100 (EST)
To: Yuri Tikhonov <yur@emcraft.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC PATCH] Support for big page sizes on 44x (Updated)
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fb412d760811241232j26477d4ficcce27ea670339fb@mail.gmail.com>
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
	<fb412d760811241232j26477d4ficcce27ea670339fb@mail.gmail.com>
Date: Tue, 25 Nov 2008 00:06:50 +0100
Message-Id: <20081124230650.29594834B020@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org, pvr@emcraft.com, dzu@denx.de,
	Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Yuri & Ilya,

In message <fb412d760811241232j26477d4ficcce27ea670339fb@mail.gmail.com>
Hollis Blanchard wrote:
> On Wed, Oct 15, 2008 at 8:22 PM, Ilya Yanok <yanok@emcraft.com> wrote:
> > These patches add support for selecting page size on PPC 44x.
> > First one adds support for 16K/64K pages while second one adds support
> > for 256K pages along with some hacks.
> 
> Leaving 256K pages aside for now, do you plan to revise the 4/16/64K
> page size patch for 2.6.29? KVM gets a huge performance boost from 64K
> pages, so I'm anxious to see this go in. I've submitted a few
> supporting patches for incidental problems caused by large pages, so I
> think it's just down to this patch itself now.

Can we please push this upstream with some priority?

Thanks.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
In any group of employed individuals the only naturally  early  riser
is  _always_  the office manager, who will _always_ leave reproachful
little notes ... on the desks of their subordinates.
                                - Terry Pratchett, _Lords and Ladies_
