Message-ID: <3C4DCEA7.3040200@embeddededge.com>
Date: Tue, 22 Jan 2002 15:42:15 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: "Kerl, John" <John.Kerl@Avnet.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: FW: Linux on 857T?
References: <C08678384BE7D311B4D70004ACA371050B7632AC@amer22.avnet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kerl, John wrote:

> Sorry, forgot to cc the mailing list.

Set burst inhibit (BIH) in the memory controller ORx register for
your DRAM banks.  If that has no effect (but I suspect it will),
disable copyback cache (this is a configuration option).  If this
has no effect (but I suspect it will), modify the code in head_8xx.S
to globally disable (or actually not enable) the cache.  If you need
help with this last one, let me know.

None of the ICEs you listed are Linux friendly.....run without them.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
