Message-ID: <DB0585C9F6F9D411BE8F00D0B7896A4CC0615C@SNCMAIL>
From: James Don <JDon@spacebridge.com>
To: "'Rod Boyce'" <rod_boyce@stratexnet.com>,
	"'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Creating RAM disks as a non root user.
Date: Mon, 3 Feb 2003 21:03:49 -0500 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I think in DENX new ELDK they may use what you just found ... but in older
versions of SELF you must become root user like you say ...

Jim

-----Original Message-----
From: Rod Boyce [mailto:rod_boyce@stratexnet.com]
Sent: Monday, February 03, 2003 9:01 PM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Creating RAM disks as a non root user.


All,

I've got to create a RAM disk for our new system.  I've found this little
utility called genext2fs the web site is
http://sourceforge.net/projects/genext2fs/
<http://sourceforge.net/projects/genext2fs/>  but my question.
What do other people use to do this? Why should I have to become the root
user just to create a RAM disk I can do everything else without becoming
root on my development machine.  I would like to be able to make this next
step as well.


Regards,
Rod Boyce.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
