Return-Path: <hzpeterchen@gmail.com>
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com
 [IPv6:2607:f8b0:4001:c05::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AF5C1A0F90
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jan 2015 18:21:21 +1100 (AEDT)
Received: by mail-ig0-f172.google.com with SMTP id hl2so364435igb.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jan 2015 23:21:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.44L0.1501061316030.1602-100000@iolanthe.rowland.org>
References: <66A26A9AA227D947AF088537F041526E2009E5@VSVR-EX10-MB1.pocatec.com>
 <Pine.LNX.4.44L0.1501061316030.1602-100000@iolanthe.rowland.org>
From: Peter Chen <hzpeterchen@gmail.com>
Date: Fri, 9 Jan 2015 15:20:58 +0800
Message-ID: <CAL411-qA2Q-eTvdKCo-9kY2wHZehas5uRuH-R3bSKRZX67BEoA@mail.gmail.com>
Subject: Re: PROBLEM: USB isochronous urb leak on EHCI driver
To: Alan Stern <stern@rowland.harvard.edu>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Tessier <michael.tessier@axiontech.ca>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 7, 2015 at 2:22 AM, Alan Stern <stern@rowland.harvard.edu> wrote:
> On Tue, 6 Jan 2015, Michael Tessier wrote:
>
>> > > > > That is interresting, however, I have an older kernel running an
>> > > > > OHCI driver which is able to handle 4 codecs. Same usb hardware
>> > > > > (codecs and hub), but older kernel on a different CPU, with much
>> > > > > less power. This makes me believe that there's a solution to make it work...
>> > > >
>> > > > Of course there is: Install an OHCI host controller and use it to drive your codecs.  It should work fine.
>>
>> What do you mean by that? The host controller is embedded in the i.MX CPU...
>> Changing the CPU is not really an option to me. Unless I am missing
>> something?
>
> I didn't realize you were talking about an i.MX-based system.  On a
> computer with a free PCI slot, it's easy to add an OHCI controller.
> iMX isn't as accomodating.
>

iMX uses chipidea controller which TT is build-in, and it does NOT support
OHCI controller.

> If there's no way to add an extra USB controller to your system then
> the only choice is to upgrade the driver software.
>
> Alan Stern
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-usb" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
BR,
Peter Chen
