From: "Jeffrey D. Kowing" <jeffrey.d.kowing1@jsc.nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14970.48222.677735.470664@igor.jsc.nasa.gov>
Date: Fri, 2 Feb 2001 07:55:42 -0600
To: Subodh Nijsure <subodh@best.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: ping says unknown protocol icmp I have /etc/protocols file.
In-Reply-To: <200102020236.SAA24035@shell9.ba.best.com>
References: <200102020236.SAA24035@shell9.ba.best.com>
Reply-To: jeffrey.d.kowing1@jsc.nasa.gov
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Subodh Nijsure writes:
 >
 > I have 2.4.1 running on my board with ramdisk loading etc.
 >
 > However when I try to use ping it says unknown protocol icmp.
 >
 > I have searched the mailing list archive and made sure that I have correct
 > /etc/protocols, /etc/services files.

Had a similar problem recently.  Sadly, my little brain does not
exactly remember the solution, but I believe the problem was that I
did not have one of the necessary libraries on my ramdisk that allowed
ping to lookup the icmp protocol in the files you mention.

I think it was one of those libresolv* or libnss* libraries.


--
Jeff Kowing
jeffrey.d.kowing1@jsc.nasa.gov

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
