Message-ID: <A109131318C4D1119AC20060088DECE30B9918@mail.adaptivemicro.com>
From: Lucinda Schafer <lucsch@adaptivemicro.com>
To: "'Rajesh S'" <srj102@yahoo.com>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Linux Kernel restart
Date: Thu, 18 Jan 2001 07:39:23 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Rajesh S [mailto:srj102@yahoo.com]  said:
>>Where can I fnd the code ?

Rajesh:
An essential command to learn in Linux:
find . -type f -print | xargs grep -n "shutdown("

Of course, substitute whatever string you want to find between the quotation
marks.
Start in the upper most directory you want to search: it will search
subdirectories.

I have used this to find many sections of mystery code.

Good Luck!

Lucinda Schafer
Staff Software Engineer
Adaptive Micro-Ware, Inc.
Fort Wayne, Indiana


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
