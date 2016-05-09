Return-Path: <andy.shevchenko@gmail.com>
Received: from mail-ob0-x235.google.com (mail-ob0-x235.google.com
 [IPv6:2607:f8b0:4003:c01::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3Gk737JFzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 19:07:42 +1000 (AEST)
Received: by mail-ob0-x235.google.com with SMTP id n10so80125711obb.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 May 2016 02:07:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20160509010952.GN4775@htj.duckdns.org>
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
 <20160508200008.GM4775@htj.duckdns.org>
 <20160509010952.GN4775@htj.duckdns.org>
Date: Mon, 9 May 2016 12:07:39 +0300
Message-ID: <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
From: Andy Shevchenko <andy.shevchenko@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 linux-ide@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
 "open list:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
 Julian Margetson <runaway@candw.ms>, Vinod Koul <vinod.koul@intel.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 9, 2016 at 4:09 AM, Tejun Heo <tj@kernel.org> wrote:
> On Sun, May 08, 2016 at 04:00:08PM -0400, Tejun Heo wrote:
>> Hello, Andy.
>>
>> On Wed, May 04, 2016 at 03:22:51PM +0300, Andy Shevchenko wrote:
>> > Tejun, since Vinod applied all necessary patches into his tree, the
>> > series now has just a dependency to whatever branch / tag he marks for
>> > it.
>> > Do we have a chance to see the SATA series be applied in your tree?
>>
>> Applied 1-22 to libata/for-4.7.  There was a couple trivial conflicts
>> which I resolved while applying but it'd be great if you can check
>> whether everything looks okay.
>>
>>  https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=for-4.7
>
> Oops, build failure.  Reverted for now.

I suppose you have to pull material from Vinod.

-- 
With Best Regards,
Andy Shevchenko
