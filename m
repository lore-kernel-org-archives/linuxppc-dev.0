Date: Tue, 8 Dec 1998 01:13:29 -0500 (EST)
From: Brad Ackerman <bsa3@cornell.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: pre-R5&miscs
In-Reply-To: <3669CABC.411EC4DE@wanadoo.fr>
Message-ID: <Pine.LNX.3.96.981208010859.4448A-100000@aynjalut.tam.cornell.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 6 Dec 1998, Martin Costabel wrote:

> This is a new installer (Redhat 5.1, I guess). The old one doesn't work
> with the files they put into the base folder. It is so new that
> apparently they have not yet had the time to write instructions. The
> following worked for me:
[^O]

This may work for hard drives, but it doesn't work for install off CD-ROM.
The installer quits after I select the CD-ROM installation option with a
second-stage bootloader "file not found" error.

[There's no vmlinux given for R5b1, so I'm using the R4 installer's copy. 
The CD from which I am trying to install is in ISO-9660/RockRidge format,
made with mkisofs on an IBM RS/6000 SP[1], with the RedHat directory in
the root.]

[1] Not that I think this part makes much difference [except to my CPU
quota], but you never know.

Brad Ackerman N1MNB      "...faced with the men and women who bring home
bsa3@cornell.edu          the pork, voters almost always re-elect them."
http://skaro.pair.com/                   -- _The Economist_, 31 Oct 1998


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
