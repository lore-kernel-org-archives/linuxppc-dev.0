Subject: Re: aic7xxx panics
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ethan Weinstein <e-d0uble@stinkfoot.org>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <3EFFD86B.7060007@stinkfoot.org>
References: <3EFFD86B.7060007@stinkfoot.org>
Content-Type: text/plain
Message-Id: <1056957083.32576.112.camel@gaston>
Mime-Version: 1.0
Date: 30 Jun 2003 09:11:24 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-06-30 at 08:27, Ethan Weinstein wrote:

>    I've posted before about this issue, and I apologize for that, I also
> apologize for posting to the dev list,  but it seems as if this is an
> oddball configuration that nobody seems to use.. everone's using IDE.
> Perhaps this driver is just not updated for the ppc arch, or has endian
> issues? Maybe the entire scsi layer for ppc has problems? I can't say.
> Regardless.. I'd like to see this fixed, this is a long-standing issue.
> I'd even be willing to lend or donate a powerdomain card to someone
> who'd be able to fix the driver for linux-ppc... I use the same card on
> several x86's with no such problems.

As I already told you privately, there's nothing I can do without more
informations on the panic. The panic/Oops log, or whatever is printed
by xmon if you have it enabled would be a good first step. Also, what
kind of machine is it ? Is there any special message displayed by
the driver before it dies ? etc...

Right now, you just say "it doesn't work", not much we can do about it...


Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
