Date: Mon, 24 Apr 2000 05:43:44 -0700 (PDT)
From: Matthew Dharm <mdharm-usb@one-eyed-alien.net>
To: Brad Hards <bradh@dynamite.com.au>
cc: Daniel Gonzalez <daniel.gonzalez@pandora.be>,
        Sheldon Easterbrook <sheldie@hotmail.com>,
        linuxppc-dev@lists.linuxppc.org, linux-usb@suse.com
Subject: Re: [linux-usb] Close to a solution. Please help !
In-Reply-To: <3904DA19.E105A181@dynamite.com.au>
Message-ID: <Pine.LNX.4.10.10004240542590.12997-100000@ziggy.one-eyed-alien.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 24 Apr 2000, Brad Hards wrote:

> Daniel Gonzalez wrote:
> > After a very long week, I think I am close to actually access my 250 Usb Zip drive.
> > I have now 2.3.99-pre6.
> You should feel priviliged. It took me months on and off to think I
> might be close.
> I do have some bad news though - you probably should have stayed with
> Paulus' tree,
> since Matt did think that there was some endian bugs, and I am pretty
> sure
> Paul had at least a floppy disk working.

Unfortunately, floppies work through completely different code paths than
Zips do.

Once I have the logs, I should be able to fix this.

Matt Dharm

--
Matthew Dharm                              Home: mdharm@one-eyed-alien.net
Senior Engineer, QCP Inc.                        Work: mdharm@qualcomm.com

I could always suspend a few hundred accounts and watch what happens.
					-- Tanya
User Friendly, 7/31/1998


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
