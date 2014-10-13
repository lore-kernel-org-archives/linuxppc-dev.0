Return-Path: <alexdeucher@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D6861A0208
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 07:39:05 +1100 (EST)
Received: from mail-qg0-x236.google.com (mail-qg0-x236.google.com
 [IPv6:2607:f8b0:400d:c04::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 98340140085
 for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2014 07:39:04 +1100 (EST)
Received: by mail-qg0-f54.google.com with SMTP id z107so7391045qgd.13
 for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2014 13:39:02 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1413231118.26478.21.camel@pasglop>
References: <1412656696.30859.122.camel@pasglop>
 <CADnq5_NFt8neiOAg896d3-DbAn0rnrE7iXaTFmkNGSg-J9oSkA@mail.gmail.com>
 <1412746096.30859.229.camel@pasglop>
 <1413231118.26478.21.camel@pasglop>
Date: Mon, 13 Oct 2014 16:39:02 -0400
Message-ID: <CADnq5_Od-cr5u8vsMbLw3sTTsbKDGwJcbvoMNgKETAeDpUXhTw@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] sound/radeon: Add quirk for broken 64-bit MSI
From: Alex Deucher <alexdeucher@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Dave Airlie <airlied@linux.ie>,
 Linux PCI <linux-pci@vger.kernel.org>, Anton Blanchard <anton@au1.ibm.com>,
 Brian King <brking@linux.vnet.ibm.com>, Yijing Wang <wangyijing@huawei.com>,
 Takashi Iwai <tiwai@suse.de>, Bjorn Helgaas <bhelgaas@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 13, 2014 at 4:11 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2014-10-08 at 16:28 +1100, Benjamin Herrenschmidt wrote:
>
>> > Further discussion with the hw teams have revealed that this is still
>> > an issue on newer asics so I think your original patch is correct
>> > after all.  Just disable 64 bit MSIs on all AMD audio PCI ids.
>>
>> Allright, I won't resend the whole series, I can just pickup my previous
>> patch. Takashi, Bjorn, Dave, this series covers your 3 areas of
>> maintainership, how do you want to proceed ? I'm happy to merge the
>> whole lot via powerpc ASAP (since it's all CC'ed stable) if you guys
>> send me the appropriate acks, otherwise, let me know.
>
> So I got an Ack from Takashi but so far silence from Bjorn and Dave :-)
>
> Ping ?

I'm fine with the radeon patches going through your tree rather than
through my tree.

Alex
