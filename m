Date: Wed, 09 May 2001 09:44:13 -0400
From: thewalthamgroup@netscape.net (Mark Phillips)
To: walser.martin@rw.hirschmann.at
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: what files should be included in initrd
Mime-Version: 1.0
Message-ID: <18C697C2.78FCC6BB.C7F6CBA8@netscape.net>
References: <040944A92C91D211954D00C095EE82680168FF32@POST>
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Walser,

In my opinion, the best source for this is the Bootdisk-Howto, available everywhere (for example http://www.linuxdoc.org/HOWTO/Bootdisk-HOWTO/)
You should skip the "ldconfig" step.
You should also refer to Initrd.txt in the Documentation subdirectory of your kernel.

Mark Phillips

Walser Martin <walser.martin@rw.hirschmann.at> wrote:
>
>
> Hi,
>
> sorry for this question, but it's the first time I try to use linux on my
> custom board.
> I'm using PPCBoot and the MontaVista kernel. Both work fine, but I don't
> know how to make a initrd image.
>
> Can someone give me a short overwiew on how to build such an image and what
> files should be included?
>
> thanks
> Martin
>
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
