Date: Sun, 2 May 1999 14:53:56 +0200 (CEST)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Michel Lanners <mlan@cpu.lu>
cc: ralfw@gatekeeper.informatik.fh-dortmund.de,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: mesh problem ?
In-Reply-To: <199904302021.WAA00338@piglet.cpu.lu>
Message-ID: <Pine.LNX.4.10.9905021452511.773-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 30 Apr 1999, Michel Lanners wrote:
> On  28 Apr, this message from Ralf Weidemann echoed through cyberspace:
> > I have today installed a new drive, so I'm not sure if it is
> > a problem with the drive itself or maybe a mesh problem. I
> > got several system lockups until yet and the below I got while
> > I tried to fsck the disk after an ealier crash. After rebooting
> > I tried again fsck the drive and all went fine. 
> > 
> > Hmm, should I get a new drive or could it be a mesh problem ?
> > This is a wide scsi drive with an adapter if it somehow matter.
> 
> That could be a problem with the IBM drive attempting negotiation for
> SCSI parameters the MESH driver doesn't know about. If I'm reading your
> log correctly, your new drive is a 'wide' type? Did you use a
> wide-to-narrow adaptor, and terminate the upper 8 bits? 
> 
> Then, you might want to look for jumpers on the drive disabling certain
> features, like wide negotiation, Target Initiated Sync negotiation
> (that used to be my problem with an IBM drive a long time ago), and so
> on. Try disabling thes features and see if it helps.

If this might help: before I had a Sym875 UW-SCSI board, I had connected my
Quantum Viking II U2W to the MESH using a wide-to-narrow adapter. I didn't have
to change any jumpers when moving the drive.

IBM driver may behave different.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
