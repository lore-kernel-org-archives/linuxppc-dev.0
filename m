Content-Type: text/plain;
  charset="iso-8859-1"
From: jim <jduey@ccc-dcs.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Problem with arch/ppc/kernel/pci.c
Date: Thu, 29 Aug 2002 15:25:14 +0000
MIME-Version: 1.0
Message-Id: <20020829203753.08D8D37ADE@server.weathercom.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I just cloned the linuxppc_2_4_devel source tree from source.mvista.com.  The
compilation errored out in arch/ppc/kernel/pci.c with a redefinition of
pci_init_resource.  When I looked at the file, sure enough, there were two
identical functions in there.

Jim Duey

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
