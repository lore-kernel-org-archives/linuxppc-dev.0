Message-ID: <37E582C0.D30E9F25@ctam.com.au>
Date: Mon, 20 Sep 1999 10:41:37 +1000
From: Brendan Simon <bsimon@ctam.com.au>
Reply-To: bsimon@ctam.com.au
MIME-Version: 1.0
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with initrd on linux-2.3.18
References: <199909171404.QAA25414@denx.local.net> <37E1F2FF.BAA72804@broadlink.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Scott Wood wrote:

> On a somewhat related sidenote, is there any work being done to access
> FLASH from within Linux, either as a file or a filesystem (or anything)?
> It would be *very* useful to read/store machine-specific configuration data
> IP address, etc) and/or update the kernel/initrd boot image remotely.
> I hear uC/Linux has a FLASHFS for certain Motorola ColdFire CPU boards.

I don't know the specifics but maybe "romfs" is what you are looking for ?
There are some docs in the linux documentation directory.

Brendan Simon.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
