Date: Mon, 1 Oct 2001 10:08:54 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "Joseph P. Garcia" <jpgarcia@execpc.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.10-ben0 doesn't see ide1
In-Reply-To: <20010930175148.29787@smtp.wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0110011006100.647-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> BTW. Once that's fixed, does media bay works on lombard & wallstreet
> machines with my new kernel ? I rewrote the media bay driver but
> didn't yet have a chance to test it on anything but Pismo.

The OF resource allocation wasn't a problem on Lombard for me - and media
bay (being handled separate from builtin IDE WRT enabling the interface)
worked with the stock source rsynced Friday afternoon. At least the IDE
probe was successful and the partition table could be read.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
