From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E42992644595405B23634@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Trying to use ELDK to build Ebony/440GP
Date: Thu, 30 Jan 2003 11:06:12 -0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In reference to a recently kicked off project using 440GP and embedded linux
...

After investigations and suggestions, I've decided to move forward with ELDK
(2.0.2). My short-term goal in life is to get embedded linux running on the
EBONY platform to kick-start our 440GP based project.

In my early investigations of tool-chains I soon found out that 440GP
support is currently provided in linuxppc_2_4_devel and not linux_2_4, so I
need this kernel for ebony support. Furthermore, as I've decided to use
ELDK, I've downloaded and installed the ppc_4xx and ppc_8xx parts of the
ELDK package. I also installed ppc_8xx since it's the version used in the
ELDK manual and I figured it would be good to have as a cross-reference.

I have tried the following permutations and combinations of kernel build
efforts (using the ELDK package, of course) with the following results:

(cfg/kern) || e-old | e-new | 2_4   | 2_4_d |
============================================|
 (TQM823L) ||   Y  |  Y     |   N   |   N   |
 ppc_8xx-  ||      |        |       |       |
-----------||------|--------|-------|-------|
 (EBONY)   ||   N  |  N     |   N   |   N   |
 ppc_4xx-  ||      |        |       |       |
--------------------------------------------

Legend:
=======
cfg/kern -->Rows are make xxx_config options and columns are kernels
e-old --> linux-2.4.4-2002-03-31.tar.bz2 (as per ELDK Doc Guide)
e-new --> linux-2.4.4-2002-10-06.tar.bz2 (latest vers @ ftp.denx.de)
2_4   --> linuxppc_2_4 bk'ed from monte vista mirror.
2_4_d --> linuxppc_2_4_devel bk'ed from monte vista mirror.



(1) Using ELDK, should a linuxppc_2_4(devel) kernel build out of the box for
the TQM823L configuration.

(2) What's the best method to successfully build a kernel for the ebony
board using the ELDK tools:
     - Port ebony support into e-new?
     - Try and work out build issues with 2_4_d configured for 'ebony'.

Wanted to solicit some feedback before I go into tangent land.


Thanks

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
