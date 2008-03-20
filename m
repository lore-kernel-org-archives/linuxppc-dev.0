Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by ozlabs.org (Postfix) with ESMTP id AFF05DE1B7
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 08:07:37 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so254175anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Mar 2008 14:07:29 -0700 (PDT)
Message-ID: <fa686aa40803201407u24d1faf9o918c12f89ce3644a@mail.gmail.com>
Date: Thu, 20 Mar 2008 15:07:29 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Linn" <John.Linn@xilinx.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH 3/3] [POWERPC] Xilinx: boot support for Xilinx uart 16550.
In-Reply-To: <20080320175601.5D86217C8055@mail127-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <12060242324116-git-send-email-john.linn@xilinx.com>
	<1206024232655-git-send-email-john.linn@xilinx.com>
	<20080320144402.695C1518064@mail63-sin.bigfish.com>
	<fa686aa40803200754j6972deenad63cf37a836f236@mail.gmail.com>
	<20080320175601.5D86217C8055@mail127-sin.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2008 at 11:55 AM, John Linn <John.Linn@xilinx.com> wrote:
> Hi Grant,
>
>  We could create a xilinx name, "xlnx,uart16550", and only use that
>  without the versions.
>

I'm okay with this as long as you don't drop the versioned property
also.  ie. Each compatible node should contain 2 strings.  The exact
version and the generic string.

My preference is something even more generic like "sparse16550" simply
because there is precedence for such a thing before Xilinx came along
(specifically, an 16550 device with reg shift and offset values).
Since it is a common variant and If you document exactly what it
means, then it should be okay to create a compatible property without
the 'xlnx,' prefix.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
