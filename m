Date: Fri, 17 Nov 2000 10:59:25 +0100
From: Olaf Hering <olh@suse.de>
To: Jim Potter <jrp@wvi.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: usb mouse error on startx
Message-ID: <20001117105923.G7846@suse.de>
References: <773747F2145F.AAA27FE@som.llu.edu> <3A143806.F992D7D@wvi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A143806.F992D7D@wvi.com>; from jrp@wvi.com on Thu, Nov 16, 2000 at 11:39:50AM -0800
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 16, Jim Potter wrote:

>
> I've just rsync'ed the latest kernel from
> ppc.linuxcare.com::linux-pmac-stable, and when compiled and run on a new MP G4
> machine, startx fails with a "Cannot open mouse" error.  The machine has this
> summer's optical usb mouse & keyboards, and usb support apears to be config'ed
> in.  What am I doing wrong?

try /dev/input/mice as device and imps/2 as protocol in you XF86Config,
see ppclinux.apple.com/~benh for more details.



Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
