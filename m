Message-ID: <3BD38FC3.8040206@metaparadigm.com>
Date: Mon, 22 Oct 2001 11:17:23 +0800
From: Michael Clark <michael@metaparadigm.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Late Broadcom link detection makes IP config (bootp) fail
References: <3BD38515.40808@metaparadigm.com> <20011021195758.E1419@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom Rini wrote:

> On Mon, Oct 22, 2001 at 10:31:49AM +0800, Michael Clark wrote:

[snip]

>
>>Why does the eth0 link come up so late? Is it possible to make the
>>broadcom driver wait for link before returning from the initialisation
>>function?
>>
>
> What driver did you use?


Not exactly sure: I have MACE, BMAC and GMAC compiled in. After matching
the log messages to the dirver source, it looks like GMAC.

~mc


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
