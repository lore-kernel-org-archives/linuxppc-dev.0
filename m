Message-Id: <5.0.2.1.2.20040722104307.01d0ab00@bhawley.mailhost.luminex.com>
Date: Thu, 22 Jul 2004 10:44:06 -0700
To: Markus Bernauer <markus.bernauer@freenet.de>,
	linuxppc-embedded@lists.linuxppc.org
From: Brian Hawley <bhawley@luminex.com>
Subject: Re: Booting Ebony-evb with u-boot and linux-devel-sourcetree
  from Denx
In-Reply-To: <40FFAB78.1000705@freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We also were trying to get this to work, however, the ebony setup ignores
the uboot parameters...so, unless you modify the code, you're stuck with
this...

However, you could configure the kernel with boot parameters hard
coded...that's what we are currently doing.



At 01:56 PM 7/22/2004 +0200, Markus Bernauer wrote:

>Hi all,
>
>I am trying to boot my Ebony-evb with u-boot and a kernel image generated
>from devel-sourcetree from Denx. It seems to me like the kernel image simply
>ignores the parameters handed over by u-boot. I also found some earlier
>threads
>that  support my thoughts. Unfortunately I am bound to u-boot and I am
>not able
>to switch back to the native bootloader that comes with the evb. Has anyone
>already a system up and running booted by u-boot? At first it does not
>matter whether
>the root filesystem comes from flash or over nfs. Any hints would be
>appreciated.
>
>Thanks in advance
>
>Markus
>
>

+==========================================================+
Brian N. Hawley                 bhawley@luminex.com
Luminex Software, Inc.          http://www.luminex.com
PO Box 5908                     voice: 909-781-4100 x112
Riverside, CA  92517            fax: 909-781-4105
+==========================================================+


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
