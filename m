From: brian.auld@adic.com
Message-ID: <995FF289C9D69747A09E4299264459540C109867@penguin.adic.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: x86(host) --> ppc(tgt) cross-tool-chain
Date: Fri, 6 Jun 2003 07:11:39 -0700 
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

Using Karim's new book "Building Embedded Linux Systems", has anyone out there successfully built an x86(host) --> ppc(tgt) tool chain using the versions stipulated in the book (gcc 2.95.3, binutils: 2.10.1, glibc, 2.2.1).

If yes:

(a) What host system are you using?

(b) Did you diverge from the directions in the book?

If no:

(a) Can someone out there suggest a known valid combination?


I anticipate needing ssh, some web-server and snmp as application requirements, so I figured it would be prudent to get the tool-chain working with glibc as opposed to uClibc.

-- Brian


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
