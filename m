In-Reply-To: <wn5oem1pd6a.fsf@linhd-2.ca.nortel.com>
References: <1BFD6304-DFEB-11D8-8C13-003065F9B7DC@embeddededge.com> <wn5oem1pd6a.fsf@linhd-2.ca.nortel.com>
Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <10A74DE9-DFF7-11D8-96F8-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: BAT mapping exported to user-space
Date: Tue, 27 Jul 2004 14:02:03 -0400
To: "Dang, Linh [CAR:2X23:EXCH]" <linh@linhdang.home>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Jul 27, 2004, at 1:34 PM, Dang, Linh [CAR:2X23:EXCH] wrote:

> # cat /proc/ppc_htab
> PTE Hash Table Information

You misunderstand.  This is the PPC Hash table, not Linux PTEs.
There are lots and lots and lots of Linux PTEs are are eventually
loaded into the PPC hash table for the processor to fetch.
What processor are you using?


> I though the kernel (2.6) only use pages for vmalloc.

There is lots of kernel space allocated through vmalloc(), plus
other specialized spaces depending upon the processor core
that are allocated through page tables.


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
