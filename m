From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14839.53124.753011.489351@argo.linuxcare.com.au>
Date: Thu, 26 Oct 2000 17:30:28 +1100 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.2.18pre17 again
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have updated my rsync trees with some more changes to my current
2.2.18pre17 source, mostly to allow a range of configs to compile
successfully.  I have also checked in the changes to the linuxppc_2_2
bk tree.  Prep-only configs should compile ok now and as a bonus they
no longer include all the pmac and chrp code that they used to.

If anyone gets compile errors with my 2.2.18pre17 tree, or the current
bk tree, please send me your .config.  I'm making a collection. :)

My primary rsync tree for the 2.2 kernel source is now at
ppc.linuxcare.com::linux-pmac-stable.  There is also a copy at
penguinppc.org::linux-pmac-stable.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
