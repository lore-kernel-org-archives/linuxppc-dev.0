Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id DFD01DDE25
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 01:50:23 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so57905anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 06:50:22 -0800 (PST)
Message-ID: <fa686aa40801160650u6c5f35d9m325a87bc8482475f@mail.gmail.com>
Date: Wed, 16 Jan 2008 07:50:22 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Joachim Meyer" <Jogi95@web.de>
Subject: Re: ml310 kernel2.6 booting problems
In-Reply-To: <537566320@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <537566320@web.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/16/08, Joachim Meyer <Jogi95@web.de> wrote:
> Hi
>
> I made an Ace file with my Kernel and load it with the Flash Card.
> I made the Initial release CF image on the card and copied my ace file in an folder, from which I boot with the DIP-Switch.
> If I used
> "console=ttyUL0 ,9600 root=/dev/xsysace/disc0/part2 rw "

try root=/dev/xsa2
Also, the ',9600' is unnecessary with the uartlite.

>
> I tried to use this:
> "console=ttyUL0 ,9600 root=fe02 rw"
> and with this, after making ace-file etc. I get:
> [   12.862678] EXT3 FS on xsa2, internal journal
> [   12.899229] EXT3-fs: recovery complete.
> [   12.982635] EXT3-fs: mounted filesystem with ordered data mode.
> [   13.038505] VFS: Mounted root (ext3 filesystem).
> [   13.094113] Freeing unused kernel memory: 96k init
> [   13.159079] Warning: unable to open an initial console.

You're probably missing the /dev/console device file

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
