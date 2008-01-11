Return-Path: <glikely@secretlab.ca>
Received: from ag-out-0708.google.com (ag-out-0708.google.com [72.14.246.246])
	by ozlabs.org (Postfix) with ESMTP id A23C1DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Jan 2008 01:52:17 +1100 (EST)
Received: by ag-out-0708.google.com with SMTP id 33so768130agc.0
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jan 2008 06:52:16 -0800 (PST)
Message-ID: <fa686aa40801110652s67b2a05al79f78144c5b527bd@mail.gmail.com>
Date: Fri, 11 Jan 2008 07:52:16 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "samppa@sundmangroup.com" <samppa@sundmangroup.com>
Subject: Re: PPC vs POWERPC
In-Reply-To: <23145.147.11.3.128.1200054808.squirrel@www.sundmangroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <23145.147.11.3.128.1200054808.squirrel@www.sundmangroup.com>
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

On 1/11/08, samppa@sundmangroup.com <samppa@sundmangroup.com> wrote:
> Hi,
> I want to port a board ( WRS SBC8265 ) from the PPC branch to the POWERPC
> branch in the Linux Kernel -- do you have any good starting points that
> describes what I need to pay attention to?
>
> I've already made a port of U-boot-1.3.1 and enabled CONFIG_OF_LIBFDT.
>
> So I need to create a DTS file, compile it with the DTC compiler and port
> the current PPC branch to the POWERPC branch to my understanding.

Yes, you're exactly right.  Use one of the dts files in
arch/powerpc/boot/dts as a starting point and read
Documentation/powerpc/booting-without-of.txt to find out what is
expected in the device tree.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
