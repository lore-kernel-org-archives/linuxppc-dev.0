Message-ID: <3977018F.35968D3A@biophys.uni-duesseldorf.de>
Date: Thu, 20 Jul 2000 15:41:35 +0200
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
To: Kohkichi Hosoda <khosoda@venus.dti.ne.jp>
CC: schmitz@opal.biophys.uni-duesseldorf.de, ajoshi@shell.unixbox.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] New XFree86-pmac rsync tree
References: <20000715113541Y.kohkichi@venus.dti.ne.jp>
		<Pine.LNX.4.10.10007171100220.22569-100000@opal.biophys.uni-duesseldorf.de> <20000720221208U.kohkichi@venus.dti.ne.jp>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kohkichi Hosoda wrote:
> Section "Screen"
>         Identifier "Screen0"
> #       Device     "r128"
> #       Monitor    "Monitor0"
>     Device     "ATY,RagePro_C"
>     Monitor    "iMac Monitor"
>         DefaultDepth      15
>
> I also tried DefaultDepth 8, and both settings also gave me
> a lot of spectrum and strange color on X.

And what exactly does the 15 and 8 bit subsections look like?

You will need fbbpp = 16 for 15 bit. And Ani's latest (yesterday's)
source has no color or accel problems whatsoever for me.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
