Subject: Re: aic7xxx panics (long)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Weinstein <e-d0uble@stinkfoot.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3F02537C.1090801@stinkfoot.org>
References: <3EFFD86B.7060007@stinkfoot.org>
	 <1056957083.32576.112.camel@gaston>  <3F00E86B.1000309@stinkfoot.org>
	 <1057053589.32576.310.camel@gaston>  <3F02537C.1090801@stinkfoot.org>
Content-Type: text/plain
Message-Id: <1057148769.32104.422.camel@gaston>
Mime-Version: 1.0
Date: 02 Jul 2003 14:26:10 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-07-02 at 05:37, Ethan Weinstein wrote:
> Ben,
>
> Even with your suggestions, I was unable to get xmon to output
> correctly, the framebuffer became too corrupted to get anything useful,
>   and the sysmap option couldn't have worked if we couldn't mount
> anything anyway, no?
>
> However, I was able to capture the oops, albeit in an interesting way.

Ok, it's real strange now. It seems you get that machine check on
the first access to the second controller while the first works fine,
though both appear to be configured properly on the PCI bus. It
looks like the second controller isn't responding on the MMIO
addresses... Can you try my devel tree with the updated driver ?
(just in case it changes anything....) I see no reason for this
problem right now though...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
