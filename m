Date: Tue, 23 May 2000 11:42:07 -0500 (CDT)
From: Nicholas Coult <coult@ima.umn.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: CONFIG_ALTIVEC=y
Message-ID: <Pine.LNX.4.10.10005231140300.15132-100000@lilac.ima.umn.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


When a kernel is compiled with CONFIG_ALTIVEC=y, I assume this
means that the kernel is aware of the Altivec registers, and keeps
track of their contents during context switches?  And that code
which uses Altivec instructions/registers will run properly with such
a kernel?  Thanks,

Dr. Nicholas Coult, Research Associate
Institute for Mathematics and Its Applications, University of Minnesota
Home Page: www.ima.umn.edu/~coult              Office: 555 Vincent Hall
Email: coult@ima.umn.edu      Phone: (612) 624-2527 Fax: (612) 624-4163


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
