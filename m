From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Brubeck <mbrubeck@hmc.edu>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: dmasound_pmac in 2_4_devel
Date: Mon, 5 Nov 2001 08:43:12 +0100
Message-Id: <20011105074312.27748@smtp.wanadoo.fr>
In-Reply-To: <Pine.GSO.4.32.0111041903030.26186-100000@turing.cs.hmc.edu>
References: <Pine.GSO.4.32.0111041903030.26186-100000@turing.cs.hmc.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I'm doing work that requires sound input.  In order to use the built-in
>microphone on my iMac (screamerawacs) I compiled the current 2_4_devel
>source, which has Iain Sandoe's dmasound_pmac patches. There were several
>issues I hope to resolve.
>
>I found a very audible clicking and popping during audio playback.  This
>is noticeable e.g. when playing normal MP3 files with xmms.  The clicking
>does not occur with the driver in the (non-devel) 2_4 tree.  I also had
>some programs lock up while playing sound.
>
>There were some other sound problems I haven't tracked down yet.  Before I
>continue working on this, I'd like to find out who is actively working on
>the dmasound_pmac driver, and where I can get more information.  I'm
>willing to work on the driver, but I'm new to the code and could use some
>help getting started.

I don't think anybody is actively working on it, I'm doing some
maintainance work. It's possible that the semaphore I added to
protect the entire driver is causing some latency, thus intruducing
the clicking. Did you try using more buffers ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
