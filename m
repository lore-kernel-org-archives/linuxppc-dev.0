Date: Fri, 21 Jan 2000 15:38:27 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Stephen Edie <sedie@terraplex.com>
cc: brad allison <jackal@aol.net>,
        Multiple recipients of list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: USB problems in 2.2.14pre9
In-Reply-To: <Pine.LNX.4.10.10001211414280.6976-100000@newhope.terraplex.com>
Message-ID: <Pine.LNX.4.10.10001211537070.782-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 21 Jan 2000, Stephen Edie wrote:

>
> Oh yes, I am using a USB keyboard right now.  It seems to happen whenever
> more than three keys are simultaneously down...  When the fourth key is
> pressed, it isn't reported.  At this point, releasing any of the four keys
> causes duplicated key strokes to be reported.  Strange.

Using a more current stack (2.3.40) I can use up to 6 keys (ie press 'em
one after another and the last pressed one works) and the 7th is ignored.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
