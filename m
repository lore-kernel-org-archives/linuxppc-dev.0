Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Message-ID: <20040714204209.33193.qmail@web61104.mail.yahoo.com>
Date: Wed, 14 Jul 2004 13:42:09 -0700 (PDT)
From: Reza Salehi <salehirp@yahoo.com>
Subject: Question - loading and running u-boot from RAM
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I am  newbie to this list and linux.  Let me start by
saying that I know that my question is FAQ and I have
read the archives.  However, I would still like to
know if some one can outline what needs to be changed
(configuration and code) in order to be able to build
a u-boot binary that can be loaded into SDRAM and
executed from their.

I realize and understand that the correct way to do
this is to copy the u-boot image into flash and
execute it from there.  However, I have the following
reasons for wanting to load and execute u-boot from
SDRAM:
1.  I am working for a very smal company that can not
afford low level debuggers.  And therefore, every time
I make a change to the u-boot code and want to test
it, I have to burn a new flash image.  We don't have a
flash burner, so I have to go and ask the company that
we are subleasing our office to let us use their flash
burner!
2.  The board I am using has socket for the flash, and
socket is flaky.  Therefore, when there is a problem,
I don't know if it is the socket or the code I
changed.

I do have a stable u-boot which I can copy into flash.
 But after that I would like to boot my system from
flash and tftp my test u-boot image into SDRAM and run
it from their.  Once I know my code is working, then I
can go ahead and burn the new u-boot image into flash.

I am using MPC8540 and u-boot 1.1.1.

I realize that this is a subject that has been talked
about before.  However, I believe(as newbie) that if
someone can outline this process, it can be big help
to developers with less budget and tools to work with.

Thanks in advance and sorry about the long e-mail,

Reza.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
