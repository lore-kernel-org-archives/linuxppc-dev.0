Message-ID: <20020820033306.23695.qmail@web21006.mail.yahoo.com>
Date: Mon, 19 Aug 2002 20:33:06 -0700 (PDT)
From: kas turi <inox_kas@yahoo.com>
Subject: BD allocation and IDMA driver question
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
 I would like to know what is the difference between
m8260_cpm_hostalloc and m8260_dp_alloc. The FCC driver
uses the former API and the serial driver uses the
latter API. When I try to use m8260_cpm_hostalloc to
allocate buffer descriptor for the SPI driver the
timesys 2.4 kernel hangs. When I use m8260_dp_alloc
the SPI driver works.
  Has anybody developed a IDMA driver for 8260 for 2.4
kernel?
  Thanks in advance.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
