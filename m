Message-Id: <199904302021.WAA00338@piglet.cpu.lu>
Date: Fri, 30 Apr 1999 22:21:02 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: mesh problem ?
To: ralfw@gatekeeper.informatik.fh-dortmund.de
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <14119.28843.240109.664411@onyx.nowhere.net>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  28 Apr, this message from Ralf Weidemann echoed through cyberspace:
> 
> I have today installed a new drive, so I'm not sure if it is
> a problem with the drive itself or maybe a mesh problem. I
> got several system lockups until yet and the below I got while
> I tried to fsck the disk after an ealier crash. After rebooting
> I tried again fsck the drive and all went fine. 
> 
> Hmm, should I get a new drive or could it be a mesh problem ?
> This is a wide scsi drive with an adapter if it somehow matter.

That could be a problem with the IBM drive attempting negotiation for
SCSI parameters the MESH driver doesn't know about. If I'm reading your
log correctly, your new drive is a 'wide' type? Did you use a
wide-to-narrow adaptor, and terminate the upper 8 bits? 

Then, you might want to look for jumpers on the drive disabling certain
features, like wide negotiation, Target Initiated Sync negotiation
(that used to be my problem with an IBM drive a long time ago), and so
on. Try disabling thes features and see if it helps.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
