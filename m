Message-ID: <37E51AEB.AFE383E0@execpc.com>
Date: Sun, 19 Sep 1999 12:18:35 -0500
From: Joseph Garcia <jpgarcia@execpc.com>
MIME-Version: 1.0
To: "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: sound sleep (more)
References: <19990919105401.015601@smtp.calvacom.fr> <37E50C29.CA2CE536@execpc.com> <19990919115435.A24214@io.nu> <37E51662.8ACADA16@execpc.com>
Content-Type: text/plain; charset=iso-2022-jp
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i forgot to add that i wrote the i/o interrupt handler code as a side thing
while trying to debug the sound not waking up.  The thing it helped me determine
is that the interrupts are still produced after sound disappears.  so the system
is still there.  sound is produced after a sleep if the module is
removed/slept/isntalled, but not if it is installed while sleeping.   so is the
sound system handled by the PMU always or just when powered up?  is it powered
up only when the module is installed?  If the PMU always handles sound upon
sleeping, why does it work when the module isn't installed at sleep?  any way to
check this further?

more questions i cant answer.

-- 
Joseph P. Garcia      jpgarcia@execpc.com      jpgarcia@lidar.ssec.wisc.edu
CS Undergraduate                      Student Employee - Systems Programmer
University of Wisconsin - Madison                            UW Lidar Group

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
