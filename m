Return-Path: <slightlyunconventional@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 4E082DDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 07:32:12 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so855252yxg.39
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Nov 2008 12:32:10 -0800 (PST)
Message-ID: <fb412d760811241232j26477d4ficcce27ea670339fb@mail.gmail.com>
Date: Mon, 24 Nov 2008 14:32:09 -0600
From: "Hollis Blanchard" <hollis@penguinppc.org>
Sender: slightlyunconventional@gmail.com
To: "Ilya Yanok" <yanok@emcraft.com>
Subject: Re: [RFC PATCH] Support for big page sizes on 44x (Updated)
In-Reply-To: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1224123753-20907-1-git-send-email-yanok@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, pvr@emcraft.com, dzu@denx.de, wd@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 15, 2008 at 8:22 PM, Ilya Yanok <yanok@emcraft.com> wrote:
> These patches add support for selecting page size on PPC 44x.
> First one adds support for 16K/64K pages while second one adds support
> for 256K pages along with some hacks.

Leaving 256K pages aside for now, do you plan to revise the 4/16/64K
page size patch for 2.6.29? KVM gets a huge performance boost from 64K
pages, so I'm anxious to see this go in. I've submitted a few
supporting patches for incidental problems caused by large pages, so I
think it's just down to this patch itself now.

-Hollis
