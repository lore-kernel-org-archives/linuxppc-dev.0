Message-ID: <369C1E55.A6B14256@jlc.net>
Date: Tue, 12 Jan 1999 23:17:25 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org,
        Hubert Figuiere <Hubert.Figuiere@solsoft.fr>
Subject: Re: Porting to NuBus PowerMacs
References: <19990112202948.028828@mail.mipsys.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

> That was the original idea, but several things makes me wonder if it
> wouldn't be simpler to just pass a list of known infos (total ram size,
> processor type, machine ID and a couple of baseaddresses) to the kernel
> and almost-hard-code things in drivers since this hardware will not
> evolve very much now ;-)

This is what we do with the embedded LinuxPPC ports now.
The data structure is a combination of things the boot rom gives
us and other configuration tidbits the Linux boot loader can find.
It wouldn't be hard to expand this to other systems.

The next challenge would be to support OF fucntions (like find_devices(), etc.)
for those drivers that run on both platforms.  As the embedded systems
mature, we may soon be doing this.......

    -- Dan



[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
