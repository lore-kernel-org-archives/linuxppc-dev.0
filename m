Date: Thu, 29 Jan 2004 12:16:18 +0800
Message-Id: <200401291216.AA122618076@actinium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: "Arun Kumar" <arunkumar@actinium.org>
Reply-To: <arunkumar@actinium.org>
To: <openh323@openh323.org>
Subject: Re:Problem in Cross compiling Pwlib for LINUX
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am cross compiling the pwlib of release 1.1pl19 in linux for the MPC8xx target using i386 as host.
I got a problem while cross compiling the pwlib and the problem is in ldap.h. No such file/directory is there. Even though it exists in /usr/include directory and I copied that file in /usr/local/include directory and also to /usr/local/lib directory. but the problem still exists. I had seen a mail in mailarchives for the month of Aug'2003 (with Subject LDAP.h memory leak) and the program code in file pldap.cxx has some code changes which are not there in new version and after equalto sign I had noticed 3D which is also not there in current version.

Are those really required for rosscompilation is that problem persists me.

Hope an early reply from u,
Thanks in advance,
Arunkumar.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
