Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: glibc vs. newlib
Date: Fri, 4 Apr 2003 15:08:26 -0800
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A80C4869@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What are the experiences and tradeoffs of using newlib vs. glibc?  I'm targetting 16M board (maybe some 8M), no swap space, and I'm concerned that adding glibc will suck much of this up.  At the same time we'd also like to be able to use off-the-shelf components like dhcpd or telnetd, and are not sure if newlib would give us too many headaches there.

Darin Johnson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
