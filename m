Date: Sat, 13 Oct 2001 00:16:03 -0800
From: Ethan Benson <erbenson@alaska.net>
To: Debian-powerpc <debian-powerpc@lists.debian.org>,
	Linux/PPC-devel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Last call for testing: yaboot-1.3.4pre3
Message-ID: <20011013001603.F10713@plato.local.lan>
References: <20011012055150.B10713@plato.local.lan> <3BC79786.47B0E3F4@mediaways.net>
Mime-Version: 1.0
In-Reply-To: <3BC79786.47B0E3F4@mediaways.net>; from Christoph.Ewering@mediaways.net on Sat, Oct 13, 2001 at 03:23:18AM +0200
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Oct 13, 2001 at 03:23:18AM +0200, Christoph Ewering wrote:
>
> Hello Ethan!
>
> Maybe I missed something, but I do not run yaboot from a bootstrap-partition. I use a
> bootscript and have yaboot on the same partition as MacOS 9.x and MacOS X. My
> Linux-kernels are in the Systemfolder that also contains the bootscript, yaboot and yaboot.conf.
>
> Is this boot-method not supported any more?

it is not supported in that any email you send me about booting
problems i won't answer, except by pointing at my documentation and
`rtfm'  its nothing personal, just your method is notoriously
unreliable and completly unsupportable from a `tech support' point of
view.

yaboot should not have any problems with this setup, it will warn
about it since its not supported by me.

> Cause yaboot 1.3.4pre3 can load the yaboot.conf but not the kernels (yaboot 1.3.4pre 1
> could not read the yaboot.conf)

please tell me the error message yaboot gave, more then likly your
config is wrong.  (yaboot should have given the full device path and
filesystem path it used to try and open the kernel files).

> BTW. This is the first yaboot after version 1.? (well the one with this funny
> penguin-picture, Ben wrote to me this is a very buggy yaboot, but it works perfectly on my
> TiPB) that gets to the yaboot-prompt on my TiPB.

yaboot has never displayed any graphics, if you have something
claiming to be yaboot that does, your not running a mainline nor
supported yaboot.

i also need to see your yaboot.conf, along with the error messages you
received.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
