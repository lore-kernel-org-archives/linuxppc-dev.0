Date: Thu, 28 Oct 1999 08:33:51 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: Still not booting
In-reply-to: <3817D80D.C986D768@jlc.net>
To: Dan Malek <dmalek@jlc.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9910280823520.5060-100000@modemcable220.93-200-24.mtl.mc.videotron.net>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As you recommended, I moved IMMAP to fa200000 (and the BCSR to fa400000).
I did that in head.S

On a different topic, I want ot compile in the MATH_EMULATION feature
but compiling fails with a error saying that some member does not exist
in a structure (I do not remember the details). I am still using an old
2.3.18 tree from the embedded directory. I am planning to download the
official CVS tree but I am wondering if the soft FP is really stable 
enough or if it is just still a wish. Anybody to comment?

Thanks

Claude

On Thu, 28 Oct 1999, Dan Malek wrote:

> Claude Robitaille wrote:
> > 
> > I works now, thanks Dan
> 
> So.....what did you do?
> 
> 
> 	-- Dan
> 
> 


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
