Date: Tue, 21 Sep 1999 12:06:39 -0600 (MDT)
From: Dan Burcaw <dburcaw@terraplex.com>
To: Brad Midgley <brad@pht.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: how to build rs/6000 kernels
In-Reply-To: <Pine.LNX.4.10.9909210911420.21470-100000@web1.turbolinux.com>
Message-ID: <Pine.LNX.4.10.9909211206150.26337-100000@newhope.terraplex.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Brad,

you want the zImage that's in chrpboot/ not boot/. The one in boot/ is for
PReP machines.

On Tue, 21 Sep 1999, Brad Midgley wrote:

> 
> hi,
> 
> i'm trying to find out why i haven't been able to build my own kernel that
> will boot. (the YDL rs6k kernel will boot on this f50)
> 
> i did "make common_config xconfig dep clean zImage" (i saved without
> changing any of the config options) and copied arch/boot/zImage to
> /tftpboot. then I booted the f50 from the net. the machine gets a default
> catch saying "PreP BOOT: Could not open deblocker." it does exactly the
> same thing if i try to boot from a floppy.
> 
> is this the right build procedure?
> 
> is openprojects a good mirror of vger? i'm using openprojects. 
> 
> is there a known-good kernel source snapshot?
> 
> do some combinations of build tools work better than others? i'm using
> fsirl's latest egcs with the latest binutils.
> 
> Brad
> brad@pht.com | http://www.pht.com/~brad/
> 
> 
> 

Dan

Terra Soft Solutions, Inc.
   Yellow Dog Linux
   "The Ultimate Companion for a Dedicated Server"
   http://www.yellowdoglinux.com/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
