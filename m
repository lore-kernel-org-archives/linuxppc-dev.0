Message-ID: <3C15194C.8020807@humboldt.co.uk>
Date: Mon, 10 Dec 2001 20:21:32 +0000
From: Adrian Cox <adrian@humboldt.co.uk>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Machine Check / Blue Smoke
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I've just posted an updated version of my machine check patch:

http://www.humboldt.co.uk/ppc_patches.html

I'd appreciate any feedback on this - I'm not happy with the current
approach taken to machinecheck on PPC. My experience of burn-in test on
7400 hardware suggests that internal machine checks indicate genuine
hardware failures.

My patch attempts to ensure that if an internal machine check occurs,
none of the potentially corrupt data in memory gets written out to disk.
It also provides a place for platform handlers to deal with the external
causes of machine check, as used on Powermac and Qspan. It includes an
example handler to provide ECC memory support on the MPC107.

--
Adrian Cox   http://www.humboldt.co.uk/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
