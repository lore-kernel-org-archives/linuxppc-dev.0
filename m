To: brian.auld@adic.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Does 'Bitkeeper' work according to the 'kernel sources' link @ pp cpenguin.org
References: <995FF289C9D69747A09E42992644595405B2361D@penguin.adic.com>
From: Roland Dreier <roland@topspin.com>
Date: 23 Jan 2003 12:21:07 -0800
In-Reply-To: <995FF289C9D69747A09E42992644595405B2361D@penguin.adic.com>
Message-ID: <52d6mnzkgc.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    brian> This is my first time using bk. I bk'ed linuxppc_2_4, but
    brian> it appears that the whole thing does not get
    brian> downloaded. For example, the "scripts/lxdialog" directory
    brian> in the kernel source tree does not have any contents other
    brian> than the SCCS directory. I find this is a consistent
    brian> problem with a smattering of diretories within the kernel
    brian> source tree. I cannot successfully execute "make
    brian> menuconfig" and am stumped.

Do "bk -r co" in your bk tree after your "bk clone" to check out the
actual source files.

 - Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
