From: mikejc@us.ibm.com
Subject: extable for modules
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 16 Oct 2000 15:30:16 -0500
Message-ID: <OF13AC26FF.9F21A375-ON8625697A.0070345B@RCHLAND.IBM.COM>
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Does anyone know why the support for exception tables in modules has been
#ifdef'ed out in arch/ppc/mm/extable.c?  I checked in 2.2.15 and 2.4test7
and it is the same in both.  The way it is, extable.c only searches the
kernel's exception table even if support for modules has been defined.
Without the exception table support, it would seem that any driver that
uses __get_user or __put_user is vulnerable to bad addresses passed from a
user.

Mike Corrigan
IBM Server Group; Rochester, MN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
