Date: Tue, 11 Jan 2000 13:05:09 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: John L Grantham <jgrantha@hannover.sgh-net.de>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Voodoo3 support?
In-Reply-To: <127rwf-0cnGnAC@fmrl00.sul.t-online.de>
Message-ID: <Pine.LNX.4.21.0001111251460.10412-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 11 Jan 2000, John L Grantham wrote:

> 
> Hi all,
> 
> I recently got a Voodoo3-compatible card, the MP960 from Vilage Tronics, 
> for my beige G3. Naturally I would like to get accelerated video with 
> this card, but haven't been able to decipher what's going on with 
> development. I read that 3dfx has released a closed driver for Intel and 
> Voodoo3 cards, and that development is underway for PPC (with beta 
> versions available somewhere), but don't grasp what I need to do to get 
> it running (newbie alert! klaxons sounding!). There seem to be multiple 
> possibilities that I can't pick out from one another...

  I am working on voodoo support, you can get a kernel/X in 
ftp://idd-01.imbc.gr/pub/voodoo3/ its not perfect yet but its getting
closer :)

> 
> Any suggestions as to where I can get more info? I mainly want 
> accelerated X. 3D support would be nice (OpenGL? Dare I hope?), but not 
> critical--though I do have a pile of Loki games I'd like to play. :-)

  accel in X is there, no 3D support yet (Glide3 is mostly done, and i am
working on porting DRI right now, no timeframe though :( )

> 
> I'm running LinuxPPC 1999 Q3 with XFree86 3.3.4 on a beige G3 MT/266 with 
> an Apple Studio Display 17" monitor. The card uses a Voodoo3-3000/5 
> chipset with 16 MB RAM and has a single VGA port and Y/C video out/in 
> ports.
> 
> While I'm on the subject, I also use both video cards under MacOS (the 
> MP960 and the on-board ATI Rage Pro). What about using multiple monitors 
> under LinuxPPC? Is there support for that?
> 
> Thanks in advance,
> 
> John
> 

  Kostas Gewrgiou


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
