Message-ID: <XFMail.990407081256.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <1288712801-202206156@mail.centricsystems.ca>
Date: Wed, 07 Apr 1999 08:12:56 +0100 (BST)
From: Gary Thomas <gdt@linuxppc.org>
To: Roy Wood <roy@centricsystems.ca>
Subject: RE: Resurrecting mkLinux
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 06-Apr-99 Roy Wood wrote:
> 
> I've got a little time and an old 6100, so I'm giving some thought to 
> raiding the mkLinux sources and getting a monolithic version of the 
> kernel going (i.e. getting rid of the whole Mach layer).
> 
> My plan is to get video working first, then the ADB keyboard, followed by 
> SCSI and network support.  Oh-- and maybe serial too, eventually.
> 
> Stop me right now if this is a stupid idea, please, but don't forget to 
> tell me why it is.  :-)
> 
> 
> Anyway, I was hoping some of you people here might be able to offer 
> advice or have some useful comments about what I'm considering doing.
> 
> Anybody?  Anyone?
> 

Your biggest problems will be:
  * Booting - perhaps BootX can be made to help here
  * Lack of Open Firmware - used to "size up" the hardware
  * 601 support - biggest worries are actually the in the hardest
    to debug - boot time and machine initialization.

Other than that, it should work.  Of course, I'm not saying it is
easy or else I would have done it myself long ago...

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
