From: "Bob Piatek" <bobtek@fishcamp.com>
To: "'GOTZON ASTONDOA'" <gastondoa@fagorautomation.es>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Can not load modules
Date: Fri, 1 Feb 2002 09:09:04 -0800
Message-ID: <000501c1ab43$26e64bf0$a2341204@P4>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <CA78D1B723D8D411AF0300508BDCF74F8C1366@NTCORREO>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I had a similar problem.  It turned out to be my development system
(yellowdoglinux) had a problem with the modutils package.  I loaded the
latest version of modutils from:

ftp://ftp.fi.kernel.org/pub/linux/utils/kernel/modutils/v2.4/


That fixed it.

Bob

fishcamp engineering
105 W. Clark Ave
Orcutt, CA  93455
TEL: 805-937-6365
FAX: 805-937-6252


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of GOTZON
ASTONDOA
Sent: Friday, February 01, 2002 6:21 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Can not load modules



  Hi,

   In trying to instal a module on my embedded linuxPPC based custom
board.
It is a simple hello world module.
   When i do insmod it says:

		insmod: unresolved symbols printk

   Can anybody help me?
   Tahnk you very much in advance.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
