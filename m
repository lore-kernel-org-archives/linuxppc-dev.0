Message-Id: <5.1.0.14.2.20030223150050.02b93d60@mail.ebshome.net>
Date: Sun, 23 Feb 2003 15:05:12 -0800
To: brian.auld@adic.com
From: Eugene Surovegin <ebs@ebshome.net>
Subject: Re: Kernel Preemption patch
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <995FF289C9D69747A09E42992644595405B23680@penguin.adic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


At 02:28 PM 2/23/2003, brian.auld@adic.com wrote:
>Has anyone successfully applied and run the linux kernel preemption patch on
>a 2.4.20 kernel. I have the following:
>
>- Latest Denx kernel (2_4_devel) running on 440GP ebony
>- 'preempt-kernel-rml-2.4.20-1.patch' applied to my kernel source
>   (I manually corrected a couple of fails and double checked a few
>    'successfully applied with fuzz' instances when applying the patch).

Please, search mailing list archives.
There was some discussion about RML patches about a month ago.

In particular, there were some bugs/typos in PPC part.
Also I had problems on 440GP, and corrected them by using MVL 2.1 tree, not
RML patches.

Eugene.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
