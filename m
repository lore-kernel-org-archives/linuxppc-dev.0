Message-ID: <20030708000947.48998.qmail@web10010.mail.yahoo.com>
Date: Mon, 7 Jul 2003 17:09:47 -0700 (PDT)
From: john duc <jjtduc@yahoo.com>
Subject: Problem installing Denx Eldk on Mandrake 9.1
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I have tried to install ELDK 2.0.2 and 2.1.0 on
Mandrake 9.1, the install program doesn't seem to
install all what needed. Here's what I do:
 
In eldk-ppc-linux-x86 directory:
./install -d /opt/eldk ppc_82xx
 
All I got after the installation are (under /opt/eldk
directory):
bin/  usr/  var/
 
./bin:
ppc-rpm   rpm
 
./usr:
lib/
 
./usr/lib:
rpm/
 
./usr/lib/rpm:
macros  rpmd  rpmopt-4.0.3  rpmrc
 
./var:
/lib  /tmp
 
./var/lib:
rpm/
 
./var/lib/rpm:
Basenames  __db.001  __db.002  Name  Packages
 
./var/tmp:
 
 
Could someone please tell me why all the install
program only setup rpm tools, not cross-compiler tools
for ppc_82xx?
 
Is it because of Mandrake 9.1?
 
Thanks in advance,
 
john


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
