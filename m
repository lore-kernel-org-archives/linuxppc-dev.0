From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23618@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Need IDE for embedded Linux project
Date: Tue, 21 Jan 2003 12:10:14 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I've just joined the mailing list. I apologize as I write this from a
windows machine. I just spent some frustrating minutes trying to tweek
Microsoft Outlook to go plain text 72 chars and I hope it worked. This
is the unfortunate side effect of the company I work for providing a
windows based dev environment for their engineers (nauseous).

Also I hope I'm not too off-topic, and if I am, I humbly ask for the
name of a different mailing list.

My group is just kicking off their first embedded linux project. The
bean counters finally bit the bullet and decided to move from VxWorks to
Linux on this project. Our hardware will be a custom board running the
PPC440GP. I am truly physched!!!

As a first step I am trying to determine what IDE makes sense given our
Department's infrastructure ... which is all windows (barf). I am aware of
the following options:

Option 1: All Native Linux.
Option 2: Native windows cross development environment.
Option 3: Vmware (linux guest on windows) with a Linux based IDE. Option 4:
Linux development server <--> PC-X server software
          (hummingbird) on windows development hosts.

Starting from a clean slate, option (1) would be my choice, but I don't
think it's practical given our installed base of Win2K workstations.

Regarding option (2), I get the impression that there are packages
available that do this, but I haven't got any real concrete hits when
searching on the web.

Regarding option (3), I just got the Vmware 30-day demo and am running RH7.2

as a Virtual Machine on my Win2K pukebox to evaluate.

Regarding option (4), it's another idea I had but haven't done much
investigation other than having thought about the possibility.

So my basic questions are as follows:

Question 1: Can anyone first confirm that option (2) is doable, and
            second recommend or point me to some of these options.

Question 2: If I go with (1) or (3), based on investigation so far, I
            would expect to use Denx's IDE that I've seen mentioned on
            this list's archives before. Some feedback about this choice
            or others as a Linux based IDE would be appreciated.

Thanks,

Brian Auld
Firmware Engineer

Brian Auld
Embedded Software Engineer
ADIC
10 Brown Rd. Ithaca, NY 14850
(607) 241-4845


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
