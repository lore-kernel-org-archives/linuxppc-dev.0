Return-Path: <festevam@gmail.com>
Received: from mail-la0-x22d.google.com (mail-la0-x22d.google.com
 [IPv6:2a00:1450:4010:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BB5601A0A05
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jan 2015 04:28:53 +1100 (AEDT)
Received: by mail-la0-f45.google.com with SMTP id gq15so18836827lab.18
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Jan 2015 09:28:49 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <66A26A9AA227D947AF088537F041526E2008FE@VSVR-EX10-MB1.pocatec.com>
References: <66A26A9AA227D947AF088537F041526E1FF44F@VSVR-EX10-MB1.pocatec.com>
 <Pine.LNX.4.44L0.1412171119590.2947-100000@netrider.rowland.org>
 <66A26A9AA227D947AF088537F041526E2008FE@VSVR-EX10-MB1.pocatec.com>
Date: Mon, 5 Jan 2015 15:28:48 -0200
Message-ID: <CAOMZO5DESCa3BOYwv0rAkoWLgTYwDdrYkNbr_jjW30s9UfR5RA@mail.gmail.com>
Subject: Re: PROBLEM: USB isochronous urb leak on EHCI driver
From: Fabio Estevam <festevam@gmail.com>
To: Michael Tessier <michael.tessier@axiontech.ca>
Content-Type: text/plain; charset=UTF-8
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 5, 2015 at 1:12 PM, Michael Tessier
<michael.tessier@axiontech.ca> wrote:

> If sound is ok when using only 1 codec and becomes choppy when adding a
> second codec, then it means that this issue is still in the 3.x kernel. This
> answer will tell me if it is worth working on using a newer kernel or not.
> I have to say that I'm not a linux expert, so I see the migration to a newer
> kernel as a quite big amount of work...

We have support for mx51 on the latest kernel. All you need to do is
to describe your hardware on a device tree file. You can refer to
arch/arm/boot/dts/imx51-babbage.dts as an example.

Should be simple for you to make such test with the latest kernel.
