Return-Path: <glikely@secretlab.ca>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.30])
	by ozlabs.org (Postfix) with ESMTP id C3010DE126
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 16:01:11 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so2360600ywh.39
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 21:01:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <497E81DD.9020408@trimble.com>
References: <497E81DD.9020408@trimble.com>
Date: Mon, 26 Jan 2009 22:01:09 -0700
Message-ID: <fa686aa40901262101r48771b8oc9fdbb6a0ede01e8@mail.gmail.com>
Subject: Re: any luck with wireless USB adaptors?
From: Grant Likely <grant.likely@secretlab.ca>
To: mike_timmons@trimble.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 26, 2009 at 8:39 PM, Mike Timmons <mike_timmons@trimble.com> wrote:
> I'm running 2.6.24 with Freescale's lite5200 as my base. I'm interested in
> this USB adaptor for wireless USB, but my web search does not make me
> confident that my effort will yield fruit.
>
> Can anyone direct me to a good source outlining success stories with
> wireless USB adaptors? At present I'm mesing with Linksys WUSB54GC and some
> driver source from Ralink, but my cross-compile is not working.

Umm, the WUSB54GC is not a "wireless USB" adapter.  It is a USB WiFi
adapter.  If you're looking for wireless USB then it is the wrong
device.

If you are looking for a suitable wifi adapter, then that device
should work, but if you can go with a PCI or a miniPCI WiFi adapter
instead then you should get better performance.  The 5200 only has USB
1.1.

I'm having good success with an Atheros miniPCI adapter at the moment
using a 2.6.28 kernel.

g.
