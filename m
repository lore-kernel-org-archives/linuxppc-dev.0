From: "Kim, Kwansuk" <kskim@neowave.co.kr>
To: "Rakesh Jagota" <j.rakesh@gdatech.co.in>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: ppc_405-nm
Date: Mon, 17 Mar 2003 22:03:21 +0900
Message-ID: <OMENKEONFDLIGLHPFALBEEMJCNAA.kskim@neowave.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
In-Reply-To: <1v5twbd61t8c8b7.170320031325@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Why don't you use the 'nm' for your host system?

It will work with any object or elf file on any host system.

(Even big-endian object on little-endian system)

 ==============================================
     Just for fun...
                                                  - Linus Torvalds
 ==============================================
  Kwansuk Kim
  Engineer, NeoWave Inc.
  Tel   +82-31-380-4927    Fax +82-31-380-4747
  E-mail: kskim@neowave.co.kr
==============================================

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org [mailto:owner-linuxppc-
embedded@lists.linuxppc.org]On Behalf Of Rakesh Jagota
Sent: Monday, March 17, 2003 5:03 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: ppc_405-nm




Hi all,
I am working on linux. I am working with custom design board based on
STBx25xx IBM ppc405 processor. I have downloaded the montavista preview kit
and install on my system. I am not finding one the option "ppc_405-nm" in my
cross-compiler bin directory. I want to see the system.map file and
vmlinux.dis file, which is not possible without this option. Can anyone
suggest me how can I include this ppc_405-nm option in my bin directory.

Thanks & Regards,

Rakesh


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
