Date: Sat, 10 Nov 2001 21:34:01 -0500
From: Joseph Manojlovich <manojlov@cse.psu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Hopefully final post on my issues
Message-ID: <20011110213401.J28196@cardassian.cse.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I was able to get BOTH my video card and my pci problems fixed just now
with a quick patch from Olaf Hering <olh@suse.de>. Patch is at
ftp.suse.com/pub/suse/ppc/kernel/BETA/patches/70__mmporter_prep_pci-2.4.7-1.fix.gz.

I made 3 quick modifications: every instance of _MACH_prep was changed
to _MACH_chrp.

Sorry for all the emails. I'm just glad this is finally working.

--
Joe Manojlovich
manojlov@cse.psu.edu
"And a thermostat on a home furnace... is that supposed to go to
 5000 degrees, do you think?"

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
