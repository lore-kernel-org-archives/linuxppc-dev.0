Return-Path: <crquan@gmail.com>
Received: from mail-ew0-f20.google.com (mail-ew0-f20.google.com
	[209.85.219.20]) by ozlabs.org (Postfix) with ESMTP id B38FDDE306
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Jan 2009 12:07:13 +1100 (EST)
Received: by ewy13 with SMTP id 13so1959332ewy.9
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 17:07:11 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <e9c3a7c20901151421o69522f71rfe6d7d9621de47eb@mail.gmail.com>
References: <200812090057.33890.yur@emcraft.com>
	<e9c3a7c20901151351p5e1b4641h1b4c8ba1ae5dcc73@mail.gmail.com>
	<e9c3a7c20901151421o69522f71rfe6d7d9621de47eb@mail.gmail.com>
Date: Fri, 16 Jan 2009 09:07:11 +0800
Message-ID: <91b13c310901151707x48b1ef8av1609c3a622c19565@mail.gmail.com>
Subject: Re: [PATCH 07/11] md: rewrite handle_stripe_dirtying6 in asynchronous
	way
From: Cheng Renquan <crquan@gmail.com>
To: Yuri Tikhonov <yur@emcraft.com>, Dan Williams <dan.j.williams@intel.com>
Content-Type: text/plain; charset=UTF-8
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

On Tue, Dec 9, 2008 at 5:57 AM, Yuri Tikhonov <yur@emcraft.com> wrote:
> Rewrite handle_stripe_dirtying6 function to work asynchronously.


On Fri, Jan 16, 2009 at 6:21 AM, Dan Williams <dan.j.williams@intel.com> wr=
ote:
> On Thu, Jan 15, 2009 at 2:51 PM, Dan Williams <dan.j.williams@intel.com> =
wrote:
>> On Mon, Dec 8, 2008 at 2:57 PM, Yuri Tikhonov <yur@emcraft.com> wrote:
>> What's the reasoning behind changing the logic here, i.e. removing
>> must_compute and such?  I'd feel more comfortable seeing copy and
>> paste where possible with cleanups separated out into their own patch.

>
> Ok, I now see why this change was made.  Please make this changelog
> more descriptive than "Rewrite handle_stripe_dirtying6 function to
> work asynchronously."

Ack, could you please make the changelog more descriptive?
and or add some of your benchmark results?

Thanks,

--
Cheng Renquan (=E7=A8=8B=E4=BB=BB=E5=85=A8), Shenzhen, China
