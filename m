Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.248])
	by ozlabs.org (Postfix) with ESMTP id 98672DDECD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Jan 2008 10:04:48 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so471541anc.78
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 Jan 2008 15:04:47 -0800 (PST)
Message-ID: <fa686aa40801281504ob920311h25c0b913c4d519d7@mail.gmail.com>
Date: Mon, 28 Jan 2008 16:04:46 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Ricardo Ayres Severo" <severo.ricardo@gmail.com>
Subject: Re: Linux boot on a ppc 405
In-Reply-To: <5ee408090801281500q467fe03anf00a5a31a5473846@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <479CAF56.30306@gmail.com>
	<fa686aa40801271315m5ba4ea08p913fd6235eb1d240@mail.gmail.com>
	<5ee408090801281453l3e6fe3e5x2f8f1b0b130ad163@mail.gmail.com>
	<20080128225505.22226C20071@mail131-dub.bigfish.com>
	<5ee408090801281500q467fe03anf00a5a31a5473846@mail.gmail.com>
Cc: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 1/28/08, Ricardo Ayres Severo <severo.ricardo@gmail.com> wrote:
> Steve,
>
> I tried that, but the System.map is not the real memory address, it's
> processed by the mmu isn't it?
>
> This is my System.map: c01e0cc4 b __log_buf
> when I try to look at the position 0xc01e0cc4 the debugger returns:
> Error: Cannot access memory at address 0xc01e0cc4

Drop the kernel offset of 0xc0000000

So; 0xc01e0cc4 becomes 0x001e0cc4 after reset.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
