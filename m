Content-Type: text/plain;
  charset="iso-8859-15"
From: Rakesh Jagota <j.rakesh@gdatech.co.in>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Library size
Date: Thu, 24 Apr 2003 13:49:38 +0530
MIME-Version: 1.0
Message-ID: <781he2iuwdfhp6z.240420031340@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,
I am working on custome design board based on IBM power PC 405. We have seen
the libraries like :

ld-2.2.3.so
libcrypt-2.2.3.so
ld.so.1
libpthread-0.9.so
libSegFault.so
libc-2.2.3.so

in the filesystem, lib folder.
"libc-2.2.3.so" is taking arounr 1.5MB space. Is there any way to reduce the
size of this file and whats the use of this file.

Thanks & Regards,

Rakesh Jagota


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
