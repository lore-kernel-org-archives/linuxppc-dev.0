Date: Mon, 30 Oct 2000 19:13:08 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Chris Leishman <chris@sharinga.com>
cc: Paul Mackerras <paulus@linuxcare.com.au>, linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18-pre17 candidate
In-Reply-To: <20001031023914.B364@nina.dev.fol>
Message-ID: <Pine.LNX.4.10.10010301912070.11674-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Also, when I tried using the new input stuff my mapping of right/middle mouse
> buttons to F9 and F10 (use append="adb_buttons=101,109" in yaboot) stopped
> working.

Which is expected. Use the proc interface to set the emulation keys (as
described in Franz' input layer docs IIRC).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
