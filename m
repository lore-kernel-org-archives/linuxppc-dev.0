Message-ID: <8D7C5F56B409554D9D46AC22195807F3061C1F@exchwenz01.dmcwave.co.nz>
From: Rod Boyce <rod_boyce@stratexnet.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Need IDE for embedded Linux project
Date: Wed, 22 Jan 2003 11:26:07 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


There is much more administration to a development machine than a server.
You also have to know how to restart dead tasks.  Find out why you keep
running out of message queues.  Cope with funny sockets.  I'm a device
driver developer who also looks after the administration.  We were a window
shop in the beginning but many of us have Linux experience from home and
other jobs.  I would check around the developers and IT staff you might be
surprised the depth of Linux knowledge you actually have.

Also I cannot recommend enough the RedHat system administration courses.  I
went from a talented armature to a good sysadmin.  I also have the sysadmin
down to about 4 hours a week.  Cron is your friend you will end up using it
in unusual ways to solve little querks.

Regards,
Rod Boyce

 -----Original Message-----
From: 	Kerl, John [mailto:John.Kerl@Avnet.com]
Sent:	Wednesday, 22 January 2003 11:14 a.m.
To:	'brian.auld@adic.com'; 'linuxppc-embedded@lists.linuxppc.org'
Subject:	RE: Need IDE for embedded Linux project


An important issue to address (perhaps the most important,
if you're new to Linux) is system administration.  When you
need help, are you going to call your company's IT department?
Is your company willing to send you to training?  Are you going
to self-educate?  This may be your key point, if you're new to Linux.

This wasn't an issue here since I've been using Unix
for many years -- so I do the administration.  Maybe someone
else on the list can speak to first-Linux-box-in-a-Windows-shop
issues.  Unix is different -- no registry, more text-based config
files, etc.  There are plenty of admin guides at the local
bookstore; also, for what it's worth, I think Unix is easier to
administer & troubleshoot than Windows, simply because you
have more visiblity.  strace alone is a lifesaver ...

If all you want to do is cross-development, there shouldn't
be too much trouble.  But you -- or someone -- should know
how to add a user, partition and mount disks, set up NFS
exports, install sshd/telnetd, etc.  Sort of "admin lite".


-----Original Message-----
From: brian.auld@adic.com [mailto:brian.auld@adic.com]
Sent: Tuesday, January 21, 2003 1:10 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Need IDE for embedded Linux project



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
