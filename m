Message-ID: <00cc01c0913a$7d647480$6c125acf@mrsl.com>
From: "Tim Moloney" <moloney@mrsl.com>
To: <linuxppc-dev@lists.linuxppc.org>,
        <yellowdog-devel@lists.yellowdoglinux.com>
Subject: Accessing global symbols from shared library
Date: Wed, 7 Feb 2001 14:16:35 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I am currently trying to port a Solaris application to Linux.  The
Solaris application dynamically loads custom shared libraries which
can access symbols in the main executable.  This is not a clean
design, but it works.  From what I've seen so far, the Linux
runtime loader does not allow a shared library to access symbols in
the main executable.

If someone knows of a linker switch or something that allows shared
libraries to access global symbols, please let me know.

Tim Moloney

ManTech Real-time Systems Laboratory
2015 Cattlemen Road
Sarasota, FL  34232
(941) 377-6775 x208


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
