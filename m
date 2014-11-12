Return-Path: <bhelgaas@google.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1BA9F1A01EE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 15:10:06 +1100 (AEDT)
Received: from mail-qg0-x22f.google.com (mail-qg0-x22f.google.com
 [IPv6:2607:f8b0:400d:c04::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 739A014012F
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Nov 2014 15:10:05 +1100 (AEDT)
Received: by mail-qg0-f47.google.com with SMTP id j107so8350998qga.34
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Nov 2014 20:10:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1415765215.5124.30.camel@kernel.crashing.org>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412746096.30859.229.camel@pasglop> <20141015221914.GD15225@google.com>
 <1413413732.11213.27.camel@pasglop> <20141111211248.GI28161@google.com>
 <1415759019.10731.1.camel@concordia>
 <1415765215.5124.30.camel@kernel.crashing.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 11 Nov 2014 21:09:42 -0700
Message-ID: <CAErSpo5yDtsFTMOuYzgF-HzKOVX2Q3cv2-63rk6yH=PSYJkg7Q@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 Brian King <brking@linux.vnet.ibm.com>, Anton Blanchard <anton@au1.ibm.com>,
 Takashi Iwai <tiwai@suse.de>, Linux PCI <linux-pci@vger.kernel.org>,
 Yijing Wang <wangyijing@huawei.com>, Alex Deucher <alexdeucher@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 11, 2014 at 9:06 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-11-12 at 13:23 +1100, Michael Ellerman wrote:
>> On Tue, 2014-11-11 at 14:12 -0700, Bjorn Helgaas wrote:
>> > On Thu, Oct 16, 2014 at 09:55:32AM +1100, Benjamin Herrenschmidt wrote:
>> > > On Wed, 2014-10-15 at 16:19 -0600, Bjorn Helgaas wrote:
>> > > >   PCI/MSI: Add device flag indicating that 64-bit MSIs don't work
>> >
>> > I'm still assuming you're going to merge this series, but I don't see it in
>> > your tree (https://git.kernel.org/cgit/linux/kernel/git/benh/powerpc.git/)
>> > yet.  Do you want me to do anything with it?
>>
>> I'm doing the powerpc tree this cycle, so it'd be in my tree, but it's not:
>>
>>   https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/
>>
>> Ben if you want me to take it let me know.
>
> Hrm, I might have dropped the ball accidentally here. Bjorn did you
> actually Ack the core changes ? In that case we should probably pick it
> up.

Yep, I acked it earlier in this thread (Oct 15).

Bjorn
