Date: Sun, 19 Sep 1999 15:49:14 -0400 (EDT)
From: Claude Robitaille <crobitaille@videotron.ca>
Subject: Re: 2.2.X MACE driver broken on the PowerMac 7200.
In-reply-to: <37E4532D.45BA7203@insu.com>
To: "Francis J. Lacoste" <francis@insu.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.10.9909191546330.537-100000@localhost.localdomain>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Francis,

I had the same problem on an 7300. I switched to using
dhcpcd instead of pump and it worked fine since then. I
looks like pump does not configure properly the interface,
however, I did not dig into the problem. (no need to).


Claude

On Sat, 18 Sep 1999, Francis J. Lacoste wrote:

> 
> I wasn't able to use NFS or FTP for the upgrade, but resort
> to a CDROM install. After the install, I realized that the
> ethernet card wasn't working properly.  DHCP works fine
> but nothing else works. If can grab an IP any time I want
> with pump, but ping doesn't work. 
> 
> If I look at ifconfig, I see that there are a lot of dropped
> packets plus some errors and some frames errors. I tried this
> with kernel 2.2.6 and 2.2.12 both with booting with Open Firmware
> or booting with BootX. 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
