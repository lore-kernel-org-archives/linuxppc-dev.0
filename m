Message-ID: <4118282C375DF64EA700135193EEB8CAAFF502@ACUSH02>
From: "Dixon, Myron @ GNS" <Myron.Dixon@L-3com.com>
To: MuthuGanesh M <muthuganeshm@myw.ltindia.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: PPC tool chain + uClibc
Date: Wed, 16 Jun 2004 09:39:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


-----Original Message-----
From: MuthuGanesh M [mailto:muthuganeshm@myw.ltindia.com]
Sent: Thursday, 10 June, 2004 12:54 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: PPC tool chain + uClibc



hello,

Atlast i can succesfully run this combination for PPC8xx

Eldk tool chain + uClibc 0.9.16  + busybox-1.00-pre3 +utelnetd

(telnetd of busybox is not working with thic combi)

with shared library support.

is there any known problem in using this combination.
Kindly advice me regarding the above

I had the same problem with busybox's telenetd.  However,
I did find that utelnetd from the following link solved
my problem.		http://www.pengutronix.de/software/utelnetd_en.html

Muthuganesh.M


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
