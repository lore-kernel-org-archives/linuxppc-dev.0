From: Darin.Johnson@nokia.com
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Interdependence of gcc to glibc/linuxheaders?
Date: Wed, 16 Apr 2003 16:39:27 -0700
Message-ID: <F0B628F30F48064289D8CCC1EE21B7A80C486C@mvebe001.americas.nokia.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I notice that during the builds of GCC it requires linux headers and actually copies headers and libraries from glibc.  Does this make GCC dependent later upon glibc and the particular linux headers?

In other words, after GCC is built, how difficult is it to replace everything with a different glibc, or uclibc, without having to recompile GCC?  If it's possible, which directories are safe to clobber and replace, and which need to be kept?

Darin Johnson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
