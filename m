To: James Don <JDon@spacebridge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: How Do I: Make My Own /root file system 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 17 Dec 2002 13:42:20 EST."
             <DB0585C9F6F9D411BE8F00D0B7896A4CC05F40@SNCMAIL>
Date: Tue, 17 Dec 2002 20:02:46 +0100
Message-Id: <20021217190251.9A0B5C6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DB0585C9F6F9D411BE8F00D0B7896A4CC05F40@SNCMAIL> you wrote:
>
> I just finished getting a basic bash shell running on my embedded PPC
> platform using a standard RAM file system from www.denx.de.
>
> Are there any instructions on line as to how I would go about making my own
> RAM FS? ... most online info seem to point to commercial distro's ... and I
> wouldn't mind learning the do's and don'ts for my self.

There is the our SELF (Simple Embedded Linux  Framework)  package  at
ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF  ,  and there is the SELF
RPM in our ELDK which is where the tarball you're using  comes  from.
You  can  download  the  build script (especially the SELF.spec file)
from our CVS server.

> In the mean time I will keep dogging for information.

There is more projects of "Linux on a flopy disk"  than  I  can  name
here. They all can be used as a starting point.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You can observe a lot just by watchin'.                  - Yogi Berra

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
