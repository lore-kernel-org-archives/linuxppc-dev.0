From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23684@penguin.adic.com>
To: ebs@ebshome.net
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: Kernel Preemption patch
Date: Mon, 24 Feb 2003 07:38:04 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks,

My problem was I was searching this mailing list (linuxppc-embedded) instead
of linuxppc-dev.

Question: The MVL 2.1 tree ... where is this? This is not at bkbits, is it?
Do I require a MV subscription to use it?

-- Brian

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net]
Sent: Sunday, February 23, 2003 6:05 PM
To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Preemption patch

At 02:28 PM 2/23/2003, brian.auld@adic.com wrote:
>Has anyone successfully applied and run the linux kernel preemption patch
on
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
