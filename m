Date: Thu, 8 Jul 1999 09:25:07 -0700 (MST)
From: Matt Porter <mporter@phx.mcd.mot.com>
To: valette@crf.canon.fr
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: PREP IDE support is broken
In-Reply-To: <Pine.LNX.3.96.990708091154.18399B-100000@liberty.chnd1.az.home.com>
Message-ID: <Pine.LNX.4.10.9907080916040.21213-100000@fwrsl-11.phx.mcd.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 8 Jul 1999, Eric Vallete wrote:

> Do anyone used PREP boards using IDE disk!!! I do.
> Months ago soemone from Moto posted a mail fixing IDE
> support. With the introduction of machine dependendent
> function pointers for ide byte handling, someone broke 
> it again.

Yes, we are using CF IDE disks on an MCP750.  Right now we just have some
hacks for supporting the edge/level changes and are working on some clean
code.

I was just looking yesterday at what is the best way to clean up
prep_pci.c so that we can have a machine type available elsewhere as you
mention.  I want to move the machine detection code so it's running
earlier and just have a function to call for the PReP machine type.
Ultimately, I'd like to see board-specific items isolated in separate
files for a more modular architecture.

--
Matt Porter                                       Motorola Computer Group
matt_porter@mcg.mot.com                           CIBU Linux Support


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
