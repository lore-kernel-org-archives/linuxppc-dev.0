Date: 12 Nov 2001 08:41:14 -0000
Message-ID: <20011112084114.25202.qmail@mailFA3.rediffmail.com>
MIME-Version: 1.0
From: "Sarnath  Kannan" <sparc64@rediffmail.com>
Reply-To: "Sarnath  Kannan" <sparc64@rediffmail.com>
To: "ashish anand" <ashisha@india.infogain.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re: "OpenPIC versus EPIC" in MPC8240 !
Content-type: text/plain;
	charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Ashish,
  what I felt was, populating reserved areas
is a bug. Thats what I accentuated. Moreover
I has said that this could be a __possible__
cause for getting bogus interrupts. I would
say there is 80% possibility.
 Moreover if u can read the EPIC manual,
u can notice that IVPR and SVPR both start
at  offset 0x50200. ( So the IVPR space is
not a continous 24 entries. It is actually
overalapped and discontinous )
 The EPIC manual clearly says "EPIC" is __adopted__
from OpenPIC specification . It never says it
conforms to the OpenPIC spec.
  I have no idea of hurting people. But if a bug
is pointed out, there is no harm in accepting it.

  lets put an end to this topic. I no more
want to discuss anything about this.

Good Luck
Sarnath


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
