From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: continuing XF402 (atimisc) problems
Date: Wed, 31 Jan 2001 15:05:17 +0100
Message-Id: <19341226073701.30276@mailhost.mipsys.com>
In-Reply-To: <p04330102b69d64c82c08@[24.163.36.97]>
References: <p04330102b69d64c82c08@[24.163.36.97]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I've been over this on the -user list and the YDL list, and cc-ed Ani
>a few times with it (no response). No one seems to have a clue as to
>the cause of the problem, which is described concisely at:
>
><http://lists.linuxppc.org/listarcs/linuxppc-user/200101/msg00672.html>
>
>(more detail available if necessary)
>
>This is on a 6500 (on-board RageII) with a RagePro PCI card. I have
>tried rolling my own XF402 build, with Ani's driver updates, and get
>the exact same XFree log result. I've also tried several of kfukui's
>402 rpms, including use of his "old drivers," again with exactly the
>same result.

Check that you have the correct fbdevhw module and that it's loaded in
your XF86Config file.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
