Mime-Version: 1.0
Message-Id: <v0420510fb360f189fb2c@[206.163.71.146]>
In-Reply-To: <l03130300b359276d80de@[192.168.10.2]>
References: <l03130300b359276d80de@[192.168.10.2]>
Date: Thu, 13 May 1999 14:24:25 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Joel Klecker <jk@espy.org>
Subject: Re: Yosemite patches
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 17:48 -0600 1999-05-07, Stephen Edie wrote:
>I regret having procrastinated the clean up and release, but anyway, the
>patches are include with this message.
>There are three patches in all.  Please apply each of them in order as two
>of the patches update the same file.  (ide-pmac.c)  Again, these patches
>apply cleanly to both 2.2.6 and 2.2.7 kernels.
>
>blueg3-pci-2.2.6.diff:
>Fixes the PCI probing/machine check problem
>
>blueg3-extra-2.2.6.diff:
>Additional patches provided in the original "challanger" .DIFFs.  Some of
>these changes may improve the stability of the Pmac.  You should apply this
>before applying the patch below.
>
>blueg3-ide-2.2.6.diff:
>Modifications which allow the IDE PCI drivers, including the CMD646 driver,
>to work properely.
[ snip patches ]

Meant to mention this earlier, but the included patches were munged.
I had to fix the wrapped lines by hand and feed --ignore-whitespace 
to patch to get them to apply.
-- 
Joel Klecker (aka Espy)                    Debian GNU/Linux Developer
<URL:mailto:jk@espy.org>                 <URL:mailto:espy@debian.org>
<URL:http://web.espy.org/>               <URL:http://www.debian.org/>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
