Message-ID: <35C119252057D511BB9F0003476BF8A208E59E@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Linux on PPC (Embedded custom board)
Date: Wed, 19 Sep 2001 09:11:59 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I need to bring up linux on PPC 750.

I have experience with ARM linux, I am new to PPC linux. Can any one point
me to where I can download the source patches for the latest releases, cross
compiler from x86 to PPC target.

I went through archive's and tried using bitkeeper. I got some code cloned
on to my computer using....
bk clone bk://ppc.bkserver.net/linuxppc_2_4 /home/siva/ppc/src

One Interesting thing I found was.. all the files are in directory /SCCS and
also has a prefix "s."  May be this is fine... but I don't understand how to
take care of things here... How to make sure all the include files are
available for routines when 'make' is executed, etc. Can some one shed some
light on this to me. I would be so thankful.

Further, I need a cross compiler... Is there any place where I can download
the precompiled version and use it for x86 host and PPC target?.

All your hints would be helpful for me. Thanks in advance.

-- Siva

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
