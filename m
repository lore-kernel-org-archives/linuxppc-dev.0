From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Giuliano Pochini <pochini@denise.shiny.it>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: slow ZIP
Date: Tue, 1 May 2001 22:32:24 +0200
Message-Id: <20010501203224.16088@smtp.wanadoo.fr>
In-Reply-To: <3AEA9D93.E6461D13@denise.shiny.it>
References: <3AEA9D93.E6461D13@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Why the ide ZIP drive is so slow ?  Raw transfer speed is only 150KB/s,
>while it goes at ~1MB/s with MacOS.

I don't think we let it do DMA because of limitations of older drive
models. If we had infos about how to differenciate DMA-capable ZIPs
from those older ones, then we could enable DMA by default.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
