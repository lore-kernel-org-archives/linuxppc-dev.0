Mime-Version: 1.0
Message-Id: <p04320402b57ce2ed6257@[192.168.240.10]>
Date: Mon, 26 Jun 2000 12:43:58 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Alain RICHARD <alain.richard@equation.fr>
Subject: Ethernet drivers no longer compiles as a module
Content-Type: text/plain; charset="iso-8859-1" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The mace and bmac ethernet driver has been modified in the current
2.2.17pre7 driver (rsync linuxcare.com.au::linux-pmac-stable) and do
not compiles any longer as modules.

It seems some variables definitions has been removed from the
module_cleanup function.
--
-------------------------------------------------------
Alain RICHARD <mailto:alain.richard@equation.fr>
EQUATION SA <http://www.equation.fr/>
Tel : +33 477 79 48 00	 Fax : +33 477 79 48 01
Applications client/serveur, ingénierie réseau et Linux

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
