In-Reply-To: <38221d223825dd81@andira.wanadoo.fr> (added by andira.wanadoo.fr)
Date: Mon, 8 Nov 1999 15:12:55 +0100
To: Florent <flobo@iname.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Newworld OF boot
Message-Id: <19991108151255.006142@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 5, 1999, Florent <flobo@iname.com> wrote:

>I'm currently working on the second stage loader (version 2.0.0a). When it
>is launched from OF, it detects the machine as a CHRP and fixes the root
>partition as the second one (this part of the code seems to be a quick add).
>

Marius Vollmer recently released "poof", an OF bootloader for NewWorld
that apparently can read the kernel from ext2. I didn't test it nor I
remember the URL, but a search on the linuxppc-usr mailing list archive
should work.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
