Date: Thu, 16 Mar 2000 23:34:35 +0100
From: Olaf Hering <olh@suse.de>
To: Chris Backas <cbackas@bigfoot.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linnux on iBooks
Message-ID: <20000316233435.A27256@suse.de>
Reply-To: linuxppc-dev@lists.linuxppc.org
References: <E12VfO2-0002sK-00@smtp01.mrf.mail.rcn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E12VfO2-0002sK-00@smtp01.mrf.mail.rcn.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Mar 16, Chris Backas wrote:

> I have an original iBook (not the new ones) and I would like to run Linux on it
> if possible.  I've read that Linux can now be booted on the iBook, but 'booting'
> and 'usable' are two *very* different things in  my book.  I've heard that
> Ethernet and the Modem aren't usable etc.. My question is, just how usable is
> LinuxPPC on an iBook?  What still doesn't work?  Thanks for any info.

The iBook works fine, the sound is currently not supported and you can't
(?) switch the resolution, use the offb driver.
Ethernet and modem works very well.
This thing is unusable with only 32MB, at least with X.
You can use BootX to use more than 8 bit color depth.


Gruss Olaf

--
 $ man 1 current_release

BUGS
       Users never read manuals...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
