From: Benjamin Herrenschmidt <bh40@calva.net>
To: Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Q: IO window remapping
Date: Thu, 11 May 2000 14:48:07 +0200
Message-Id: <20000511124808.2431@mailhost.mipsys.com>
In-Reply-To: <391289B2.4060C2DF@mpifr-bonn.mpg.de>
References: <391289B2.4060C2DF@mpifr-bonn.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, May 5, 2000, Albrecht Dreﬂ <ad@mpifr-bonn.mpg.de> wrote:

>As a result, any pcmcia package operation (like card insertion) fails as
no io
>ports can be assigned.
>
>I hope this question is not too dumb: What is the correct range for this IO
>window?  Where should I fix it (probabely in arch/ppc/kernel/pmac_pci.c)?
>
>Thanks in advance, Albrecht

The cardbus bridge is on the external PCI of Uni-N, so, on this machine,
the IO base should be 0xf2000000.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
