Message-ID: <3937E6B7.1BFCD6B8@mvista.com>
Date: Fri, 02 Jun 2000 09:54:15 -0700
From: Mark Hatle <fray@mvista.com>
MIME-Version: 1.0
To: Grant Erickson <grant@borg.umn.edu>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux/PPC Installer Source Code
References: <Pine.SGI.4.21.0006021058070.183027-100000@tigris.borg.umn.edu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Grant Erickson wrote:
>
> Is the source code available for the Linux/PPC 1999 installer (based on
> the Red Hat installer)? I've scoured the Linux/PPC 1999 CD and can't seem
> to locate it among the other source code and SRPMs.
>
> I'm particularly interested in looking at loading software onto "virgin"
> embedded boards and/or field upgrade strategies for embedded boards with
> semi-frequent software upgrade requirements.
>
> Thanks,
>
> Grant Erickson
>

If you can find the source CD for the LinuxPPC Reference Release 1.0 it
should be the same source code.

ftp://mirror.linuxppc.org/linuxppc-dev-rel/1.0/
(look in the misc/src directory)

Also, if that fails, it's almost identical to the RedHat 6.0 installer
source.  (The majority of the changes delt with the MacOS partition
scheme.)

The scheme is to compile a list of packages that are to be installed,
parse the dependency information so that you (hopefully) can install
things in order of whats needed, and then perform the install.

You may want to hop onto #mklinux on your local efnet IRC server and ask
for some suggestions if you are planning on writing an installer.  I
would stay away from the RedHat type installers for an embedded
application, there are better tools out there.

--Mark

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
