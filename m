Message-ID: <39381A81.9934BB46@grn.georet.net>
Date: Fri, 02 Jun 2000 16:35:14 -0400
From: Ryan Boder <rboder@grn.georet.net>
Reply-To: rboder@grn.georet.net
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel error
Content-Type: text/plain; charset=us-ascii; x-mac-type="54455854"; x-mac-creator="4D4F5353"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just rsynced the source for linux-pmac-stable from linuxcare.com.au.
It compiled fine but when I tried to reboot it started to work and then
I got this...


Kernel stack overflow in process co1c5260, r1 = co1c57a0



Then Xmon said....


vector 500 at pc = co172594, msr = 9032, sp = co1c57a0 [colc56f0]
current = co1c5260, pid = 0, comm = swapper



What exactly does that mean? I was using the linux-pmac-stable source so
I this code has obviously worked before. Am I missing some library
functions? If anyone has any advice I'd be greatful. By the way, I am
using a G4 AGP 400mhz and I used the dot.config from Pauls site.


Ryan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
