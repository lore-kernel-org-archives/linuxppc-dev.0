Message-ID: <39CA8E56.31BB8000@lanl.gov>
Date: Thu, 21 Sep 2000 16:40:22 -0600
From: Ben Sapp <bsapp@lanl.gov>
Reply-To: bsapp@lanl.gov
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: getting at bootp IP address
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a number of MVME2300 computers that boot a small ramdisk with
bootp and tftp.  All the MVME2300s are doing basically the same thing so
I would like to avoid having a different kernel for each computer.  I
would like the program that is started in place of init in the ram disk
to set up the network based upon the IP address that was obtained from
bootp.  I do not know how to get at this information though.   Can I
read it from non-vlatile ram?  Can I send out another bootp braodcast
from user-land and get the information again?

Thanks for any leads.

--
Ben Sapp                         Los Alamos National Laboratory
email: <mailto:bsapp@lanl.gov>   Phone: (505)667-3277
Fax:   (505)665-7920             URL:   http://www.neutrino.lanl.gov/
--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
