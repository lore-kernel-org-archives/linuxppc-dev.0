From: benh@kernel.crashing.org
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
Cc: <linuxppc-dev@lists.linuxppc.org>,
	"David N. Welton" <davidw@dedasys.com>
Subject: Re: sleep: trackpad settings, screen blanking
Date: Wed, 21 Nov 2001 19:25:24 +0100
Message-Id: <20011121182524.13700@mailhost.mipsys.com>
In-Reply-To: 
 <Pine.LNX.4.33.0111211648200.21616-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.33.0111211648200.21616-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>IIRC the problem was with asynchronous ADB resetup after sleep; pmud
>doesn't wait for that to finish and restores settings that are
>subsequently cleares by the bus resetup. BenH thought about ways to fix
>this, nothing final yet (that's why it reads 'for now' above :-).

My current kernels will block ADB writes when the bus is still
beeing reset/probed. So pmud should work. However, I had some
reports of pmud just screwing up the trackpad in this case, which
may be related to a bug in an older release of pmud. One problem
is that I think debian did some updates to it, but the maintainer
did't update the official version. Well, I might have just missed
something here as I use to rely on debian's version :)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
