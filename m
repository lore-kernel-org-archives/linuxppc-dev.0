Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20020621150853.2021.qmail@web21104.mail.yahoo.com>
Date: Fri, 21 Jun 2002 08:08:53 -0700 (PDT)
From: Tim Lai <laitingwai@yahoo.com>
Subject: Can I run linux without a file system?
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I am porting linux on a custom board.
I am using the bootrom to load vmlinux onto
RAM, and I am in the middle of getting the console/
serial driver to work.
All the documents I read have refer the console as
/dev/ttyS, and state that to communicate to the
console, I have to set it up with open("/dev/ttyS").

Does that means I have to have some sort of file
system in linux?

Thanks.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
