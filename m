From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Clark <michael@metaparadigm.com>,
	Tom Rini <trini@kernel.crashing.org>,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Late Broadcom link detection makes IP config (bootp) fail
Date: Mon, 22 Oct 2001 15:17:35 +0200
Message-Id: <20011022131735.28492@smtp.adsl.oleane.com>
In-Reply-To: <3BD3A110.40703@metaparadigm.com>
References: <3BD3A110.40703@metaparadigm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Some of GMAC initialisation seems to be delayed and done asynchronously.
>Shouldn't link be detected and the interface brought up before return
>from the init function? Otherwise it is impossible to use this driver
>with IP autoconfig and NFS root.

It's not supposed to be synchronous. It's ipconfig's fault not to wait
long enough.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
