From: ramp@oddjob.uchicago.edu
Date: Sun, 30 Jan 2000 22:04:25 -0600 (CST)
cc: linuxppc-dev@lists.linuxppc.org
Subject: devel kernels 2.3.41
In-Reply-To: <200001300356.WAA12189@marcus.pants.nu>
Message-ID: <Pine.LNX.4.10.10001302151040.3009-100000@xpol.uchicago.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Hi everyone,

I hope I'm not the only one having problems getting a working
2.3.41 kernel. I downloaded the stock 2.3.41 from kernel.org.
This one didn't even compile. There were some problems with
pci.h. I then decided to go back to 2.3.40 and apply the
pre-patches [1..4] where 4 is the final 2.3.41. I was able
to successfully compile a 2.3.41pre3. However on boot I was
unable to use my keyboard/mouse. The boot messages seemed to
indicate that the keyboard and mouse were recognized. Any ideas
and fixes? 2.3.41pre2 also compiled successfully. On boot this
led to disk errors and I was asked to fsck. This was a total loss
since I could not type anything with the keyboard and mouse not
even recognized. I'm now back to my 2.2.14 and things seem OK.

Any suggestions/comments/ideas/patches will be most welcome.

Thanks - Ramprasad

The following table summarizes  ---

  Kernel           Compiles      Boots
 2.3.41               No
 2.3.41pre3          Yes          Yes (No keyboard/mouse)
 2.3.41pre2          Yes          no (led to fsck/ No kbd/mouse)l


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
