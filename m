From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Bill Fink <billfink@mindspring.com>,
	LinuxPPC Developers <linuxppc-dev@lists.linuxppc.org>
Cc: YellowDog Linux General <yellowdog-general@lists.terrasoftsolutions.com>
Subject: Re: dmasound audio patch
Date: Mon, 8 Apr 2002 13:49:04 +0200
Message-Id: <20340714231722.28828@smtp.adsl.oleane.com>
In-Reply-To: <20020407172358.36f3fd3e.billfink@mindspring.com>
References: <20020407172358.36f3fd3e.billfink@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Hi,
>
>A friend of mine, Rob Scott, worked up a patch to the dmasound driver
>that fixes some of the PPC endianness issues by doing byte swapping
>in the driver.  He uses it on a Titanium PowerBook, and I am using it
>on a dual 500 MHz G4 with good results.  Before the patch, using xmms
>with the AudioCD Reader plugin, I had to use the esound driver since
>the OSS driver just gave static.  Now I can use the OSS driver directly,
>so there's no need to run the esd daemon.
>
>I know this patch probably isn't politically correct, since as I understand
>it Linus doesn't believe that things such as byte swapping should be done
>in the kernel.  But then he lives on a little endian machine and doesn't
>need to mess with dozens of broken audio applications.  So if you're not
>worried about kernel political correctness, you might want to give this
>patch a try.  Of course I make no warranty of any kind, but I can attest
>that it works fine on a couple of different PPC systems with BenH kernels
>around 2.4.18.

Hi Bill, thanks for the patch, though I decided long ago I agree with linus
and that swapping shouldn't take place in the kernel. If we go that way, we
make sure userland apps will never be fixed ;)

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
