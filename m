Date: Mon, 25 Feb 2002 19:15:48 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202260315.g1Q3Fmt18809@dave.home>
To: dan@embeddededge.com, dash@xdr.com
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Cc: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>David Ashley wrote:
>
>
>> There is a bug in linux PPC, and that's what I'm trying to resolve. Here
>> is the last part of the printout of the execution of that program:
>
>You must have some unique hardware :-).  I've run 10,000 iterations on a 8260
>and 860 with the 2.4.18-pre7 kernel, and on my 7410 PowerBook with 2.4.11
>without any failures........Let us know what you fix to make it work for you.
>
>Thanks.
>
>
>	-- Dan
>
>


Maybe you can point me to some discussion of how linux operates? I mean,
once the memory is mapped with the page tables, what happens once the
process does a read to a page? Does that generate a page fault? The crucial
thing is read followed by write. I suspect the problem isn't in the setting
up of the page, but in when it gets accessed and the resultant exceptions
or interrupts that produces. It seems like all discussions on this are
outdated and only apply to older kernels...

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
