From: Thomas Capricelli <capricel@enst.fr>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: long-term 7600-booting patch
Date: Tue, 2 Nov 1999 13:33:04 +0100
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <9911021333290B.13454@uranium>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>> 	As my 2.1.125 kernel from linuxppc R4 was always fine but I need to
>> boot new kernels, I've made this patch. Not that I understand a lot of what
>> i've done, mainly backporting the mesh code from 2.1.125.
>> 
>> 	At least, my mac now always BOOT. Before applying this patch, I had to
>> try between 6 and 16 times to boot my computer. You DON'T know how tiring this
>> is
>
>Can you please try a 2.3.x kernel? I suffered from a similar problem and it was
>solved in 2.3.x.

	My macintosh still won't boot with 2.3.24 until my pacth is applied.
This problem is here since march, 1999. on all >2.2.0 kernel.

	Also, the stock-linux-2.3.24 is really a pain to compile. The kernel won't link
until pmu is added (pmu is powerbook-related stuff), and some other minor
problems.
	Also, I don't dare to compile anything as module anymore, cause most of
them won't link when insmod'ed. (unresolved symbols such as memcpy...)

	Those two last problems are here since at least 2.3.18, probably  much
more longer.

Thomas

-- 
Thomas Capricelli

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
