Date: Thu, 14 Jan 1999 18:15:40 +0000 (GMT)
From: Jules Bean <jmlb2@hermes.cam.ac.uk>
To: "David A. Gatwood" <marsmail@globegate.utm.edu>
cc: Hubert Figuiere <Hubert.Figuiere@solsoft.fr>,
        Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Porting to NuBus PowerMacs
In-Reply-To: <Pine.LNX.3.96.990113124607.9183B-100000@globegate.utm.edu>
Message-ID: <Pine.SOL.3.95q.990114181426.13019B-100000@red.csi.cam.ac.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 13 Jan 1999, David A. Gatwood wrote:

> 
> On Wed, 13 Jan 1999, Hubert Figuiere wrote:
> 
> > I'm investigating the possibilities to support 5200/6200 (and its
> > little brother 5300/6300) just because this machine is:
> > 
> > a) not supported by either MkLinux or LinuxPPC
> > b) I have one (in fact my fiancee has it).
> > 
> > There are several custom chips inside (like on any other Mac).
> > First the big problem is that 6200 is a PowerPC inside a 68040
> > machine. It uses a "CAPELLA" custom chip as a bus translation
> > unit. This may be a problem since I don't think it is used in any
> > supported PowerMac.

I've got a 5200, which I am keen to get Linux running on at some point.
The amount of time I can put aside is rather variable, but I do have some
limited kernel hacking experience from my NetBSD/m68k days..

Willing to help, in short,

Jules

/----------------+-------------------------------+---------------------\
|  Jelibean aka  | jules@jellybean.co.uk         |  6 Evelyn Rd	       |
|  Jules aka     | jules@debian.org              |  Richmond, Surrey   |
|  Julian Bean   | jmlb2@hermes.cam.ac.uk        |  TW9 2TF *UK*       |
+----------------+-------------------------------+---------------------+
|  War doesn't demonstrate who's right... just who's left.             |
|  When privacy is outlawed... only the outlaws have privacy.          |
\----------------------------------------------------------------------/


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
