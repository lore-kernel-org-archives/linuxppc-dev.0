Date: Tue, 12 Oct 1999 10:50:02 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Lou Langholtz <ldl@chpc.utah.edu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
Message-ID: <19991012105001.A698@drow.res.cmu.edu>
References: <199909101833.UAA17210@piglet.cpu.lu> <3802D9FE.1C166944@chpc.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3802D9FE.1C166944@chpc.utah.edu>; from Lou Langholtz on Tue, Oct 12, 1999 at 12:49:34AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Could you check whether that kernel has the patch I posted to this list
last month applied?

The patch was in Message-ID: <19990912141014.A17732@them.org>.



On Tue, Oct 12, 1999 at 12:49:34AM -0600, Lou Langholtz wrote:
> 
> Michel Lanners wrote:
> 
> > On  10 Sep, this message from Lou Langholtz echoed through cyberspace:
> > > After getting an extra 2MB VRAM for my PowerMac7500 and seeing that only
> > > 2MB were still being recognized (despite having just added the 2MB to
> > > total to 4MB VRAM), I dug into the controlfb.c code from 2.2.11 and
> > > 2.2.12 and made the following changes to get all 4MB VRAM recognized:
> > . . .
> >
> > I guess it's time to clear thgis up once and for all. By the way, I do
> > have 4 MB of VRAM, and all of it is detected with the current version
> > of controlfb.....
> 
> Update:
> 
> Even with 2.2.13pre15, the stock controlfb.c still doesn't detect the
> 4MB VRAM in my 7500 (I just tried it). I have to hack controlfb.c to get it
> to use all 4MB. This is perhaps a bug specific only to the PowerMac 7500/100
> as others have reported that all VRAM was detected on their PowerMac's
> without making any changes like I've had to do.
> 
> 
> 


Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
