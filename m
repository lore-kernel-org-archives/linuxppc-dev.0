Message-ID: <381F0BA9.FC093C92@drgw.net>
Date: Tue, 02 Nov 1999 10:04:57 -0600
From: Troy Benjegerdes <hozer@drgw.net>
MIME-Version: 1.0
To: David Edelsohn <dje@watson.ibm.com>
CC: Florent <flobo@iname.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: Newworld OF boot
References: <9911022024.AA40132@marc.watson.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



>         I have not heard of a FreeBSD PowerPC port, but NetBSD does have a
> Mac PowerPC port.  NetBSD seems to create an OF note section.

I have booted NetBSD using standard bootp and tftp, along with holding
down the 'N' key on a blue & white G3. I've also gotten a CHRP linux
kernel image to load and start unzipping the kernel. However, I haven't
had the time in the last couple of months to actually work out all the
details with where the kernel loads and setting the processor memory
management in a state where the linux boot code can handle it.

-- 
--------------------------------------------------------------------------
| Troy Benjegerdes    |  troy@blacklablinux.com    |    hozer@drgw.net  
|
|    Unix is user friendly... You just have to be friendly to it first. 
|
| This message composed with 100% free software.    http://www.gnu.org  
|
--------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
