Date: Fri, 15 Sep 2000 03:03:40 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: "Halfmann, Klaus" <khalfmann@libra.de>
cc: "'linux-fsdevel@vger.kernel.org '" <linux-fsdevel@vger.kernel.org>,
        "'linuxppc-dev@lists.linuxppc.org '" <linuxppc-dev@lists.linuxppc.org>,
        "'flar@allandria.com '" <flar@allandria.com>,
        "'Olaf Hering'" <olh@suse.de>
Subject: Re: Status of HFS+ support
In-Reply-To: <F14441D40E5AD3118886005004607AD10BDDA5@MAIL1>
Message-ID: <Pine.GSO.4.21.0009150254510.3380-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 15 Sep 2000, Halfmann, Klaus wrote:

> (thanks once again), or even better might help me :). And
> yes, It should run ox x86 linux, too. But I have no acces to
> a machine to really test it. (On the other hand, which x86
> linux user needs this :)

Put several fs images on anon ftp and let's see what testing can be
done...

> P.S. could someone tell me how to join the linux-fsdevel
> 	List ? (or better read it offline)

Huh? It's majordomo-controlled. I.e. mail to majordomo@vger.... and put
subscribe linux-fsdevel
into body. Then reply to the confirmation request - all as usual.

ObTesting: folks, it's share-the-testsuite time. Really. Everyone who has
such stuff is very welcome to post URLs.

ObTesting2: any volunteers for testing new minixfs? It looks like I've got
something that approaches beta. I'll put it on anon-ftp tonight and post
the URL - it may be dangerous, so don't try it on production boxen...
It should fix the races analogous to ext2 ones.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
