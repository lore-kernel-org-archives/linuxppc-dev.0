Return-Path: <bhelgaas@google.com>
Received: from mail-qg0-x22c.google.com (mail-qg0-x22c.google.com
 [IPv6:2607:f8b0:400d:c04::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 716771A0C42
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Feb 2015 02:29:50 +1100 (AEDT)
Received: by mail-qg0-f44.google.com with SMTP id l89so52836383qgf.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 03 Feb 2015 07:29:47 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1422923108.4625.2.camel@ellerman.id.au>
References: <1422712065-9403-1-git-send-email-haokexin@gmail.com>
 <1422712065-9403-2-git-send-email-haokexin@gmail.com>
 <1422844101.11325.4.camel@ellerman.id.au>
 <CAErSpo7B3yDQiD0XA9nBxb4tFW0BktT0EZ3HCZENOYQqMy0m_Q@mail.gmail.com>
 <1422923108.4625.2.camel@ellerman.id.au>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 3 Feb 2015 09:29:25 -0600
Message-ID: <CAErSpo4Q8Oj3Yk6mFfZGmEfLGFdum9LJRumhT5yE4x0ctC3mGw@mail.gmail.com>
Subject: Re: [PATCH 01/15] PCI: introduce pci_device_to_OF_node() for
 !CONFIG_OF
To: Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Kevin Hao <haokexin@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 2, 2015 at 6:25 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> On Mon, 2015-02-02 at 09:47 -0600, Bjorn Helgaas wrote:
>> On Sun, Feb 1, 2015 at 8:28 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > On Sat, 2015-01-31 at 21:47 +0800, Kevin Hao wrote:
>> >> So we can avoid the ugly #ifdef in some drivers.
>> >>
>> >> Signed-off-by: Kevin Hao <haokexin@gmail.com>
>> >> ---
>> >>  include/linux/pci.h | 2 ++
>> >>  1 file changed, 2 insertions(+)
>> >
>> >
>> > Hi Bjorn,
>> >
>> > Do you mind putting this into your next for 3.20? Or giving us an ACK for it if
>> > you prefer.
>>
>> I think it makes more sense to merge this along with the other 14
>> patches that remove the #ifdefs (at least, I assume that's what they
>> do; I haven't seen them).
>
> Yeah that is what they do.
>
> The problem with doing it that way is the rest of the patches are splattered
> all across the tree, so getting them merged as a series will require a lot of
> searching for acks.
>
> If you merged this one for 3.20 we could then merge the rest of the series one
> at a time as the respective maintainers get around to it during the 3.21 cycle.
>
> I probably should have said all that in my original mail :)
>
> Anyway it's not a big deal, but that's why it'd be nice if you could take it.

OK, sure, I didn't get the hint that it would be preferable for me to
take it.  I'll merge it for v3.20.

Bjorn
