Date: Tue, 6 Nov 2001 16:16:36 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Martin Costabel <costabel@wanadoo.fr>
Cc: <hemphill@drea.dnd.ca>,
	<yellowdog-general@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Ti Powerbooks and YDL 2.1 - Problems
In-Reply-To: <3BE78CB0.54E8C9F8@wanadoo.fr>
Message-ID: <Pine.LNX.4.33.0111061612410.13471-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Well I've just spent an interesting two days documenting a problem with
> > the Ti Powerbooks and the 2.4 series kernels.  I have access to two
> > 500Mhz Ti's with the Matshita DVD-ROM SR-8187 drives.  When I tried to
> > follow Dan Burcaw's experimental instructions on doing a yup update of
> > YDL2.0 to 2.1 I ran into the problem that a mount of any CD returned the
> > error message "wrong media type" (I hadn't used the CD at all since
> > moving to the 2.4 series kernels).
>
> Did you try to mount it via the loop device:
>
>  mount -o loop -t hfs /dev/cdrom /mnt/wherever
>
> If this works, then you hit a kernel bug that was discussed 2 weeks ago
> on linuxppc-dev

This isn't a bug but a new feature :-) At least it's part of a new feature
(reblocking for filesystems where hardware blocksize doesn't match
filesystem blocksize via loopback) introduced in recent 2.4 kernels
(which-shoud-really-be-renamed-2.5 (tm)).

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
