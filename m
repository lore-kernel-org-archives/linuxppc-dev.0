Message-ID: <023EF71CB65AA949A2C510353690C86B027F7A@rokonet-e.rokonet.co.il>
From: Eli Brin <eli.brin@rokonet.co.il>
To: "'I?igo Lopez Barranco'" <ilopez@albatros-sl.es>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Little survey: SCM systems?
Date: Thu, 15 Jul 2004 12:27:41 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Ingo,

For embedded Linux development, we use CVSNT (CVS for windows) as our SCM.

For our Enterprise and Desktop applications we use Rational Clear-Case.  But
I'm seriously thinking of moving to CVS here as well.

For an IDE we use Eclipse for Linux, and it works OK with the CVSNT.  The
platform is ELDK 3.0.

All three CVSNT - Eclipse - ELDK work very well together.

Best regards,
Eli Brin




-----Original Message-----
From: ilopez@albatros-sl.es [mailto:ilopez@albatros-sl.es]
Sent: Wednesday, July 14, 2004 5:40 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Little survey: SCM systems?


Hi.
I would like to know which software configuration system (SCM) have you
people tried. I found a nice comparison between different systems in
http://better-scm.berlios.de/comparison/ and Vesta seems really interesting.
Anyone has tried it?
We're using CVS right now, but it has some limitations wich can become quite
bothering. Also, we have to compile for several different platforms, using
different toolchains, etc. Any SCM that you would recommend for this kind of
development.
Thanks in advance.

Iñigo


 This mail arrived via mail.pineapp.net

****************************************************************************
********
This footnote confirms that this email message has been scanned by
PineApp Mail-SeCure for the presence of malicious code, vandals & computer
viruses.
****************************************************************************
********

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
