Message-ID: <381CD1E5.3F4E45FF@drgw.net>
Date: Sun, 31 Oct 1999 17:33:57 -0600
From: Troy Benjegerdes <hozer@drgw.net>
MIME-Version: 1.0
To: Paul Mackerras <paulus@linuxcare.com>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: PMU daemon
References: <381C4668.56DAA6A0@drgw.net> <99110110154101.20520@argo.linuxcare.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul Mackerras wrote:
> 
> On Mon, 01 Nov 1999, Troy Benjegerdes wrote:
> 
> > ncftpget ftp://ftp.linuxcare.com.au/pmud-0.2.tar.gz
> > Remote host has closed the connection.
> > ncftpget: cannot open ftp.linuxcare.com.au: remote host closed control
> > connection.
> 
> Not again...
> 
> Fixed now.

Thanks, I wound up getting a copy from someone else.

Now that I've had a chance to try it, I've got a couple of comments.

You have a typo at the end of 'pwrctl'.. pwrctl_3400 $i instead of
pwrctl_3400 $1

I have a 3400 set up to use DHCP, and the pump client gets quite unhappy
when the pwrctl scrips do the ifconfig up and ifconfig down. I changed the
scripts to do 'ifup eth0' and 'ifdown eth0' so that the Red-hat style
scripts are called instead, which take care of starting a stopping pump.
This is also handy if you move to multiple places, and each has a DH CP
server. Just close the lid, and when you open it back up, you'll
automagically get a new working IP. Of course this plays havoc with any
open connections, or using the machine as a server, but I would suspect
very few (if any) powerbook users leave open connections or use the machine
as a server.

Is there a way to read the battery voltage from the console using pmud?

Finally, does anyone know how feasable it would be to make pmud have the
same API as the intel-ish APMD, since there are a bunch of nice X
apps/applets for various window managers that talk to APMD?

-- 
--------------------------------------------------------------------------
| Troy Benjegerdes    |  troy@blacklablinux.com    |    hozer@drgw.net   |
|    Unix is user friendly... You just have to be friendly to it first.  |
| This message composed with 100% free software.    http://www.gnu.org   |
--------------------------------------------------------------------------

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
