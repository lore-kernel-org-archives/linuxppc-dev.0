Message-ID: <8D7C5F56B409554D9D46AC22195807F3156FF0@exchwenz01.dmcwave.co.nz>
From: Richard Williams <richard_williams@stratexnet.com>
To: "'Todd'" <to_dd@yahoo.com>,
	linux <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: syslog opinion
Date: Wed, 20 Aug 2003 08:52:30 +1200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We are using busybox syslog. It is quite slow compared with writing to a
file although so far it is coping. Syslog remote logging uses UDP and I have
found it to be useless as many messages are lost. We log to a local file on
our embedded ramdisk and then telnet in and cat or tail to look at it. You
still need a way to limit the log file size. I have thought about writing a
driver that implements a circular buffer to send syslog output to but for
now I just delete the file if it gets too big.

Richard

-----Original Message-----
From: Todd [mailto:to_dd@yahoo.com]
Sent: Wednesday, 20 August 2003 3:25 a.m.
To: linux
Subject: syslog opinion



I was wondering if anyone has an opinion on using the
syslog function to log events in an embedded system.
What the pros and cons might be between using syslog
(with its large feature set) vs. writing a simple
logging utility.  I'm not giving too many deatils
about what I'm trying to accomplish, since I'd rather
hear about other people's experiences have been.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
