Message-ID: <C08678384BE7D311B4D70004ACA371050B7635BA@amer22.avnet.com>
From: "Kerl, John" <John.Kerl@Avnet.com>
To: "'Dr. Craig Hollabaugh'" <craig@hollabaugh.com>,
	Marius Groeger <mag@sysgo.de>, John Fisher <John.Fisher@nec.com.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: cygwin and embedded linux
Date: Thu, 22 Aug 2002 16:48:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


When starting to do Linux/PPC cross-development about
a year ago (my current workplace is an NT shop) I
experimented with cygwin, for some of the same reasons
as the original poster describes.  & I found that cygwin
was roughly 20x slower than Linux running on the same class
of PC (!).  I could pop the Red Hat CD in the drive and install
the actual OS, & have it up & running in half an hour
-- less time than it took to complete a single,
moderately complex job.  I soon found that cygwin wasn't
saving me any time at all.


-----Original Message-----
From: Dr. Craig Hollabaugh [mailto:craig@hollabaugh.com]
Sent: Thursday, August 22, 2002 4:39 PM
To: Marius Groeger; John Fisher
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: RE: cygwin and embedded linux



At 09:36 AM 8/22/2002 +0200, Marius Groeger wrote:
>2. The "emulation" will never be 100%. Maybe 99%. Maybe 99.99%. That last
>   fraction can be a major PITA, because it is not obvious. To compile a
>   kernel you need a lot of tools with a lot of explicit and implicit
twists
>   to them. It is just a gut feeling that I wouldn't want to rely on this,
>   if I don't have to. The native way just seems the better way to do it to
>   me.

Just because your running on Linux doesn't mean anything because your
duplicating
the environment for cross-compiling anyway. So what does it matter if cygwin
runs
the cross tools or if Linux runs them?



I'm curious ...

How many out there actually are compiling PPC code natively on a PowerPC
Linux box for their embedded devices?

If so, do you run the same development versions on your desktop?

How do you handle the FPU issues?

Craig


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
