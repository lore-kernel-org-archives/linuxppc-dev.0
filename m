Return-Path: <dan.j.williams@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.168])
	by ozlabs.org (Postfix) with ESMTP id 1D51DDE333
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 09:28:36 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1363610wfg.15
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 14:28:35 -0800 (PST)
MIME-Version: 1.0
Sender: dan.j.williams@gmail.com
In-Reply-To: <e9c3a7c20901151351p5e1b4641h1b4c8ba1ae5dcc73@mail.gmail.com>
References: <200812090057.33890.yur@emcraft.com>
	<e9c3a7c20901151351p5e1b4641h1b4c8ba1ae5dcc73@mail.gmail.com>
Date: Thu, 15 Jan 2009 15:21:18 -0700
Message-ID: <e9c3a7c20901151421o69522f71rfe6d7d9621de47eb@mail.gmail.com>
Subject: Re: [PATCH 07/11] md: rewrite handle_stripe_dirtying6 in asynchronous
	way
From: Dan Williams <dan.j.williams@intel.com>
To: Yuri Tikhonov <yur@emcraft.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-raid@vger.kernel.org, linuxppc-dev@ozlabs.org, wd@denx.de,
	dzu@denx.de, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 15, 2009 at 2:51 PM, Dan Williams <dan.j.williams@intel.com> wrote:
> On Mon, Dec 8, 2008 at 2:57 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
> What's the reasoning behind changing the logic here, i.e. removing
> must_compute and such?  I'd feel more comfortable seeing copy and
> paste where possible with cleanups separated out into their own patch.
>

Ok, I now see why this change was made.  Please make this changelog
more descriptive than "Rewrite handle_stripe_dirtying6 function to
work asynchronously."

Regards,
Dan
