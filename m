Mime-Version: 1.0
Message-Id: <v04210100b429450856b2@[206.173.238.95]>
In-Reply-To: 
 <Pine.LNX.4.10.9910112307420.26305-100000@sleepchamber.apt5.msoe.edu>
References: 
 <Pine.LNX.4.10.9910112307420.26305-100000@sleepchamber.apt5.msoe.edu>
Date: Tue, 12 Oct 1999 13:13:41 -0700
To: ian reinhart geiser <geiseri@msoe.edu>, linuxppc-dev@lists.linuxppc.org,
        linuxppc-user@lists.linuxppc.org
From: Randall R Schulz <rrschulz@cris.com>
Subject: Re: Argo UML and LinuxPPC
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ian,

Well, I've gone through the installation and configuration exercise 
for ArgoUML, version 0.70. Fortunately, I had the same problem as 
you. Fortunately? Yes, since had I not, I wouldn't have searched for 
the solution...

If you're experiencing the same problem as I had, the symptom being a 
complaint about not being able to load ...MetalLookAndFeel.class, 
then the problem is that your display is in a color mode not 
supported by the current Java and / or XF86 server and / or display 
driver. In my case, the driver is Anthony Tong's ATI Rage Pro driver 
("video=aty128fb") in 32 bit-per-pixel mode. Setting the display to 8 
bits allowed ArgoUML to start up fine (even though it made a lot of 
other things ugly--it also made everything faster, of course).

Search the LinuxPPC-User archives for specifics of the problem and 
solutions or workarounds. The following statement appears on 
<http://khendricks.ivey.uwo.ca/linuxppc/jdk/main.html>, where the 
LinuxPPC JDKs are made available:

* The current XF68_FBDev Xserver is inconsistent when specifying 
bits-per-pixel, color depth, and color masks. This causes a problem 
running JDK 1.2.X with jfc (swing) classes. A fix is available in the 
form of a source code patch for XF68_FBDev and/or a precompiled 
XF68_FBDev replacement (which needs a revised XF86Config file to 
correctly specify color depths. See the following archive to get the 
required downloads.


I hope this helps.

RandyS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
