Message-Id: <m14EwY1-001SzWC@bucks>
From: diekema@bucks.si.com (diekema_jon)
Subject: Root keys on bk://bitkeeper.fsmlabs.com:5000 have changed
To: cort@ftsoj.fsmlabs.com, linuxppc-embedded@lists.linuxppc.org,
        cort@fsmlabs.com
Date: Sat, 6 Jan 2001 11:50:29 -0500 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It appears that the BitKeeper repository at bk://bitkeeper.fsmlabs.com:5000
has changed.  What happened to the previous BK tree?  Was it replaced with the
2.4.0 baseline?

dell 112} cd ../fsmlabs-linux-2.5
dell 113} bk pull -z9
Nothing to pull.
dell 114} bk parent
Parent repository is bk://hq.fsmlabs.com:5005
dell 115} cd ../fsmlabs-linux-2.5
dell 116} bk parent
Parent repository is bk://hq.fsmlabs.com:5005
dell 117} bk pull -z9
Nothing to pull.
dell 118} cd ../fsmlabs-linux-2.4
dell 119} bk parent
Parent repository is bk://bitkeeper.fsmlabs.com:5000
dell 120} bk pull -z9
You are trying to pull from an unrelated package.  The root keys:
        cort@ftsoj.fsmlabs.com|ChangeSet|20010106071759|19793|5c81b698cda31832
        cort@medea.fsmlabs.com|ChangeSet|19991223032020|43000|42b4afcd8eebec4a
for the ChangeSet file do not match.
Please check the pathnames and try again.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
