From: benh@kernel.crashing.org
To: <mrz5149@acm.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.17 and dmasound
Date: Fri, 22 Feb 2002 19:31:22 +0100
Message-Id: <20020222183122.9042@mailhost.mipsys.com>
In-Reply-To: <3C7688D2.CD7E7565@ne.mediaone.net>
References: <3C7688D2.CD7E7565@ne.mediaone.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I recently downloaded 2.4.17 from kernel.org hoping to get my kernel
>more up to date. Unfortunately, when I looked at the dmasound driver I
>didn't see the fix for dbdma DEAD problems which occur on some
>PowerComputing machines.
>
>Was this patch ever submitted or was it lost in the shuffle?

Look for 2.4.18, it will be released soon, or use one of the PPC trees
or the current 2.4.18-rc4. All of them should work.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
