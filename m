Date: Thu, 10 Dec 1998 12:55:50 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Alois Fertl <alois_fertl@TalkNet.de>
cc: Cort Dougan <cort@persephone.cs.nmt.edu>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>,
        Matt Porter <mmporter@home.com>, VALETTE Eric <valette@crf.canon.fr>
Subject: Re: PREP Hardware goes IDE again
In-Reply-To: <366EEC05.E01F2088@talknet.de>
Message-ID: <Pine.HPP.3.96.981210125441.17076z-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 9 Dec 1998, Alois Fertl wrote:

> The second problem was that the partition table of a DOS IDE drive
> was not recognized unless I specified hda=swapdata at the boot prompt.
> IDE CD-Rom drives were not recognized at all. All the required coding
> to operate IDE devices correctly is already there but it is not used
> for PREP hardware. I changed ide.h so that PREP is handled the same
> way as CHRP. This makes IDE disks and CD-roms work without the need
> to specify boot options.

Indeed, I always wondered why this was this way. But not having any IDE
interface...

	Gabriel.


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
