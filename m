Message-ID: <399EB420.AD15500@pop.agri.ch>
Date: Sat, 19 Aug 2000 18:21:52 +0200
From: Andreas Tobler <toa@pop.agri.ch>
MIME-Version: 1.0
To: Linuxppc-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: rpm-Q
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,
sorry this seems to be a general linux Q, dev-part I think, has anyone a
solution for this:
rpm -ihv glibc-2.1.91-18.src.rpm
only packages with major numbers <= 3 are supported by this version of RPM
error: glibc-2.1.91-18.src.rpm cannot be installed

I want to build rpm's by myself, but I get the same msg with rpm-4.x, is this a
classical chicken & egg problem?

BTW: rpm -q rpm rpm-3.0.4-6x

Thanks,

Andreas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
