Message-ID: <373A192B.F6940925@wanadoo.fr>
Date: Thu, 13 May 1999 02:13:31 +0200
From: Martin Costabel <costabel@wanadoo.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Scilab compiling problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Since I had scilab running on linuxppc-R5 a long time ago, I wanted to
give the src.rpm from the redhat powertools directory a try. After a
little tweaking, it compiles OK and goes almost all the way through the
process of building the binary rpm.

Right at the end, it stops after the following lines

+ cd /var/tmp/scilab-root/usr/bin
+ ln -s ../lib/scilab-2.4.1/bin/scilab scilab
+ exit 0
Processing files: scilab
Finding provides...
Finding requires...
BFD: /var/tmp/scilab-root/usr/lib/scilab-2.4.1/bin/SEpsf: invalid string
offset 2147554304 >= 256 for section `'
BFD: /var/tmp/scilab-root/usr/lib/scilab-2.4.1/bin/SEpsf: invalid string
offset 2147561472 >= 256 for section `'
BFD: /var/tmp/scilab-root/usr/lib/scilab-2.4.1/bin/SEpsf: invalid string
offset 2147569664 >= 256 for section `'
BFD: /var/tmp/scilab-root/usr/lib/scilab-2.4.1/bin/SEpsf: invalid string
offset 2147612672 >= 256 for section `'
BFD: /var/tmp/scilab-root/usr/lib/scilab-2.4.1/bin/SEpsf: invalid string
offset 2147706880 >= 256 for section `'

After this it sits there and does nothing until killed by ctrl-C.

Does anyone know what this means? What is BFD?
Is this a bug in a) rpm b) binutils c) egcs d) somewhere else?
The file .../SEpsf is a binary which seems to run OK. 

--
Martin


--
Martin

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
