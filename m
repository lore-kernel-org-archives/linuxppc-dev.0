Message-Id: <5.1.0.14.2.20020820231900.03a9e008@pop.prodigy.net>
Date: Tue, 20 Aug 2002 23:26:03 -0700
To: linuxppc-embedded@lists.linuxppc.org
From: Eugene Surovegin <ebs@innocent.com>
Subject: Re: Restructuring of ibm_ocp_enet driver
Cc: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20020821043627.GF18818@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David,

At 09:36 PM 8/20/2002, you wrote:
>The patch below make some first steps to restructuring the
>ibm_ocp_enet driver .

Wouldn't it be nice BEFORE another ibm_ocp_enet restructuring to fix bugs
introduced in the previous one?

Current version has broken rx ring buffer management and the typo in
requesting IRQ for RXDE event.

I send bug report and a fix (maybe not the most elegant one) to Armin two
weeks ago. Nothing happened :(


Thanks,

  Eugene Surovegin <mailto:ebs@innocent.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
