Subject: consistent_alloc
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Wed, 2 Apr 2003 19:56:24 +0200
Message-ID: <742AC4678EF8464697DDDFE3B40F6ECD07E28F@SRV-MAILRND.azisa.co.za>
From: "Flavio Pereira" <Flavio.Pereira@za.flextronics.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All

I'm using Denx Linux 2.4.20 running on am MPC8xx processor. I've found
that consistent_alloc does not seem to allocate memory from a cache-free
region. I've found that even though I'm using consistent_alloc to
allocate memory, I still have to flush the relevant area before letting
the CPM read it. Is there any alternative to consistent_alloc, or should
it work and possibly I am using it incorrectly?

Regards
Flavio Pereira

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
