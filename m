Date: Sun, 9 Jul 2000 17:22:19 -0400
From: Tom Vier <thomassr@erols.com>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: Mark Hatle <fray@mvista.com>, linuxppc-dev@lists.linuxppc.org,
        yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: RFC: Changing default partition type for linux/ppc
Message-ID: <20000709172219.C12414@zero>
References: <39661556.D86AA2DA@mvista.com> <20000707222137.1227@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000707222137.1227@192.168.1.10>; from bh40@calva.net on Sat, Jul 08, 2000 at 12:21:37AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jul 08, 2000 at 12:21:37AM +0200, Benjamin Herrenschmidt wrote:
> >My vote: let the kernel still look for Apple_UNIX_SVR2 the way it does
> >now.  Then I would like it to be able to use anything that starts with
> >"Linux".  That way people can name there parts types whatever they want,
> >but Linux_ext2 and Linux_swap should be defaults.

> The kernel will be able to use anything. The only kernel change concerns
> the root auto-detect stuff.

> What will need to change, however, are the various distro installers,
> pdisk, yaboot, perhaps quik, ...

i'd vote for "ext2", "hfs", etc. call them what they are, and keep it simple,
instead of "Linux_Ext2fs" or something similar.

imho, partition types should be a "soft" standard. eg, an installer should
default to only showing Apple_UNIX_SVR2 (or whatever standard partition
names are created) unless the user selects "show all" or similar option.
this is somewhat offtopic, though.

--
Tom Vier <thomassr@erols.com>
DSA Key id 0x27371A2C

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
