From: Benjamin Herrenschmidt <bh40@calva.net>
To: <guillaume.laures@noos.fr>, <mlan@cpu.lu>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Trying to enable backside on a G4
Date: Sun, 9 Jul 2000 22:34:37 +0200
Message-Id: <20000709203437.29766@192.168.1.10>
In-Reply-To: <3968A9E4.256BDDBA@noos.fr>
References: <3968A9E4.256BDDBA@noos.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>So I attached a correct (I think) user-space script called L2BS_enable.sh
>which I'm going to
>propagate on linuxppc-users, tell me what you think about. I will try to
>work on kernel space then.
>
>I'm just unsure of the behaviour of :
>while test 1 = $((`cat /proc/sys/kernel/l2cr | awk -F : '{print
>$1}'`&0x00000001)); do wait; done

I'd rather fix the kernel code. The set_L2CR function in the kernel is
supposed to already handle all that work of waiting for the cache,
invalidating, etc...

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
