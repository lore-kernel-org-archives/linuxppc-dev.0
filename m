Date: Tue, 10 Feb 2004 13:04:16 +0100
From: Sebastian Henschel <linux@kodeaffe.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] URL change linux on laptops
Message-ID: <20040210120416.GC19619@fuchi>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="qOrJKOH36bD5yhNe"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

hi there...

attached is a cosmetic patch for arch/power/Kconfig which updates the URL
for kenneth's page and introduces the URL of tuxmobil.org.

thanks and bye,
 sebastian

--qOrJKOH36bD5yhNe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="lol-tuxmobil.power.diff"
Content-Transfer-Encoding: quoted-printable

diff -Naur linux-2.6.2-ben1-stir4200.orig/kernel/power/Kconfig linux-2.6.2-=
ben1-stir4200/kernel/power/Kconfig
--- linux-2.6.2-ben1-stir4200.orig/kernel/power/Kconfig	2004-02-10 11:52:25=
=2E834112592 +0100
+++ linux-2.6.2-ben1-stir4200/kernel/power/Kconfig	2004-02-10 12:36:51.1269=
26496 +0100
@@ -9,9 +9,9 @@
=20
 	  Power Management is most important for battery powered laptop
 	  computers; if you have a laptop, check out the Linux Laptop home
-	  page on the WWW at
-	  <http://www.cs.utexas.edu/users/kharker/linux-laptop/> and the
-	  Battery Powered Linux mini-HOWTO, available from
+	  page on the WWW at <http://www.linux-on-laptops.com/> or
+	  Tuxmobil - Linux on Mobile Computers at <http://www.tuxmobil.org/>
+	  and the Battery Powered Linux mini-HOWTO, available from
 	  <http://www.tldp.org/docs.html#howto>.
=20
 	  Note that, even if you say N here, Linux on the x86 architecture

--qOrJKOH36bD5yhNe--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
