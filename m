Return-Path: <glikely@secretlab.ca>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by ozlabs.org (Postfix) with ESMTP id D67CCDDF61
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 05:20:42 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so3945350pyi
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Oct 2007 12:20:41 -0700 (PDT)
Message-ID: <fa686aa40710151220u12f024dfu78a1537c8d8bcdd8@mail.gmail.com>
Date: Mon, 15 Oct 2007 13:20:39 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: aauer1 <aauer1@gmx.at>
Subject: Re: Linux booting problem on Xilinx ppc
In-Reply-To: <13219154.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12694083.post@talk.nabble.com>
	<fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
	<12696686.post@talk.nabble.com> <13219154.post@talk.nabble.com>
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

On 10/15/07, aauer1 <aauer1@gmx.at> wrote:
>
> Hello
>
> I'm also working with ML403 board from Xilinx and have the same problem as
> you. The boot process stops after decompressing with the message "Now
> booting the kernel". We also used gcc-4.1.0 for the cross compilation. So, I
> would be glad to know, which gcc version have you used to get a working
> kernel!

First step:

Get a JTAG debugger and look at the __log_buf address.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
