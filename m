From: Benjamin Herrenschmidt <bh40@calva.net>
To: Mark Hatle <fray@mvista.com>, <linuxppc-dev@lists.linuxppc.org>,
        <yellowdog-devel@lists.yellowdoglinux.com>
Subject: Re: RFC: Changing default partition type for linux/ppc
Date: Sat, 8 Jul 2000 00:21:37 +0200
Message-Id: <20000707222137.1227@192.168.1.10>
In-Reply-To: <39661556.D86AA2DA@mvista.com>
References: <39661556.D86AA2DA@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>with "Apple_"
>
>My vote: let the kernel still look for Apple_UNIX_SVR2 the way it does
>now.  Then I would like it to be able to use anything that starts with
>"Linux".  That way people can name there parts types whatever they want,
>but Linux_ext2 and Linux_swap should be defaults.

The kernel will be able to use anything. The only kernel change concerns
the root auto-detect stuff.

What will need to change, however, are the various distro installers,
pdisk, yaboot, perhaps quik, ...

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
