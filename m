Mime-Version: 1.0
Message-Id: <v04205501b42fdd706586@[192.168.1.40]>
Date: Sun, 17 Oct 1999 22:15:05 +0200
To: linuxppc-dev@lists.linuxppc.org
From: "N.G. Temme" <niek@database.rino.nl>
Subject: sendmail problem solved
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I do not now if anyone has this problem but here is the solution.


I could not get sendmail working right to send mailforms from a web 
page. Then I started to think. Why use a mail-server to send 
mailforms. I am looking for a mail client.


The solution I found was to use mail module from perl.

you Mail-Sendmail-0.77.tar.gz can form the perl website and after 
compiling it works great. You have to change you're perl scripts 
though.



Niek Temme
niek@nepheware.rino.nl

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
