Date: Wed, 21 Nov 2001 17:01:17 +0000
Subject: Re: dmasound_pmac in 2_4_devel
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Matt Brubeck <mbrubeck@hmc.edu>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20011121191904.6573FDB9E0@atlas.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben wrote:
>>I'm doing work that requires sound input.  In order to use the built-in
>>microphone on my iMac (screamerawacs) I compiled the current 2_4_devel
>>source, which has Iain Sandoe's dmasound_pmac patches. There were several
>>issues I hope to resolve.
>>
>>I found a very audible clicking and popping during audio playback.  This
>>is noticeable e.g. when playing normal MP3 files with xmms.  The clicking
>>does not occur with the driver in the (non-devel) 2_4 tree.  I also had
>>some programs lock up while playing sound.
>>
>>There were some other sound problems I haven't tracked down yet.  Before I
>>continue working on this, I'd like to find out who is actively working on
>>the dmasound_pmac driver, and where I can get more information.  I'm
>>willing to work on the driver, but I'm new to the code and could use some
>>help getting started.
>
> I don't think anybody is actively working on it, I'm doing some
> maintainance work. It's possible that the semaphore I added to
> protect the entire driver is causing some latency, thus intruducing
> the clicking. Did you try using more buffers ?

I'm kinda out of circulation at the moment ... so no active stuff.
Will be back to it tho ... when work schedule permits.

ciao,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
