From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23682@penguin.adic.com>
To: acurtis@onz.com, brian.auld@adic.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: Kernel Preemption patch
Date: Mon, 24 Feb 2003 04:54:14 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks for the help.

What's with RML? Does that stand for Robert M Love (just a guess)?

I did search the list archives but was searching on "kernel preemption/ive
patch" which didn't give me any hits.

Do people typically search this mailing list archives via the web link at
penguinppc.org? That's what I use.

-- Brian

-----Original Message-----
From: Allen Curtis [mailto:acurtis@onz.com]
Sent: Sunday, February 23, 2003 5:34 PM
To: brian.auld@adic.com; linuxppc-embedded@lists.linuxppc.org
Subject: RE: Kernel Preemption patch

> Has anyone successfully applied and run the linux kernel
> preemption patch on
> a 2.4.20 kernel. I have the following:
>
> - Latest Denx kernel (2_4_devel) running on 440GP ebony
> - 'preempt-kernel-rml-2.4.20-1.patch' applied to my kernel source
>   (I manually corrected a couple of fails and double checked a few
>    'successfully applied with fuzz' instances when applying the patch).
> - Kernel compiled with 'Kernel preemption =y' in make oldconfig

Yes, but didn't you get any compile errors? There are some missing brackets,
etc. to fix. Check the attached message from this list.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
