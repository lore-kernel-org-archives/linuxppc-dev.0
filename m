Return-Path: <mans@mansr.com>
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
 by lists.ozlabs.org (Postfix) with ESMTP id 3r3GsT2RPhzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 19:14:04 +1000 (AEST)
From: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Tejun Heo <tj@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, linux-ide@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>,
 "open list\:LINUX FOR POWERPC PA SEMI PWRFICIENT"
 <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Christian Lamparter <chunkeey@googlemail.com>,
 Julian Margetson <runaway@candw.ms>, Vinod Koul <vinod.koul@intel.com>
Subject: Re: [PATCH v2 00/23] ata: sata_dwc_460ex: make it working again
References: <1461661404-1952-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <CAHp75VeeosHAxhXnWY7rc5o969TDyHPRWGdV7kh1_uR+TBa=aA@mail.gmail.com>
 <20160508200008.GM4775@htj.duckdns.org>
 <20160509010952.GN4775@htj.duckdns.org>
 <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
Date: Mon, 09 May 2016 10:13:59 +0100
In-Reply-To: <CAHp75VeMkZOZgGj2b3tHw7h7V42qM9dCz1qWs8nQENBMGWuZHQ@mail.gmail.com>
 (Andy Shevchenko's message of "Mon, 9 May 2016 12:07:39 +0300")
Message-ID: <yw1xmvnziofc.fsf@unicorn.mansr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andy Shevchenko <andy.shevchenko@gmail.com> writes:

> On Mon, May 9, 2016 at 4:09 AM, Tejun Heo <tj@kernel.org> wrote:
>> On Sun, May 08, 2016 at 04:00:08PM -0400, Tejun Heo wrote:
>>> Hello, Andy.
>>>
>>> On Wed, May 04, 2016 at 03:22:51PM +0300, Andy Shevchenko wrote:
>>> > Tejun, since Vinod applied all necessary patches into his tree, the
>>> > series now has just a dependency to whatever branch / tag he marks for
>>> > it.
>>> > Do we have a chance to see the SATA series be applied in your tree?
>>>
>>> Applied 1-22 to libata/for-4.7.  There was a couple trivial conflicts
>>> which I resolved while applying but it'd be great if you can check
>>> whether everything looks okay.
>>>
>>>  https://git.kernel.org/cgit/linux/kernel/git/tj/libata.git/log/?h=3Dfo=
r-4.7
>>
>> Oops, build failure.  Reverted for now.
>
> I suppose you have to pull material from Vinod.

The failure the build bot reported is due to the DMA patches not being
in the tree.

--=20
M=E5ns Rullg=E5rd
