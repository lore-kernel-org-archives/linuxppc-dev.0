From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tony Mantler <nicoya@apia.dhs.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Fwd: CPU features
Date: Mon, 2 Apr 2001 00:40:34 +0200
Message-Id: <20010401224034.32550@smtp.wanadoo.fr>
In-Reply-To: <v04003a02b6ed59f245ee@[24.70.162.12]>
References: <v04003a02b6ed59f245ee@[24.70.162.12]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I just booted with the second CPU wedged (that is to say, bootx from MacOS
>9) with the same kernel to see what it would do with only 1 cpu, and it
>still stops at the same place, so I'm guessing the problem should be
>reproducable on a single-cpu system running an SMP kernel, if that helps
>any.

Well, I booted succesfully the Pismo (which doesn't use the lost_interrupts
stuff) with an SMP kernel. So either this is broken, or something else
related to powersurge is broken.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
