Date: Tue, 25 May 2004 10:26:21 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Andriy Korud <a.korud@vector.com.pl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: 2.6.x on 405EP evaluation board?
Message-ID: <20040525102621.B1329@home.com>
References: <80908CC5B2C9DB47AAF8C77892FCB44315F795@lion.vector.com.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <80908CC5B2C9DB47AAF8C77892FCB44315F795@lion.vector.com.pl>; from a.korud@vector.com.pl on Tue, May 25, 2004 at 03:03:56PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, May 25, 2004 at 03:03:56PM +0200, Andriy Korud wrote:
>
> Hi, does anybody tried to run 2.6.x on 405EP eval board (actually I have PPChameleon which is very close to it).
> For me kernel hangs immediately after uncompressing.

The 2.6 support for 405EP eval board is just that, it's for the 405EP
eval board (Bubinga).  Don't expect it to run on your "PPChameleon"
board. You need to do a board port, "very close" or "it's just like
IBM's board" doesn't cut it. :)

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
