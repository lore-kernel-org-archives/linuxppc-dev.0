In-Reply-To: <Pine.LNX.4.10.10001121541450.18221-100000@opus.bloom.county>
Date: Thu, 13 Jan 2000 11:25:35 +0100
To: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@lists.linuxppc.org,
        hughc@babcockbrown.com
From: BenH <bh40@calva.net>
Subject: Re: USB Mouse Changed in 2.2.14
Message-Id: <20000113112535.015369@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 12, 2000, Tom Rini <trini@kernel.crashing.org> wrote:

>Yes, yes it has.  And since Paul didn't sync up to something current
>enough ( :(((( ) 2.2.14 and 2.4.0 are looking lilke they'll have different
>userland configs still.

Paul just included the hack to put back the mouse at device 10 32. rsync
again, it should work.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
