Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3E68F912.7000602@tataelxsi.co.in>
Date: Sat, 08 Mar 2003 01:24:58 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: installing ncurses for cross compiling 
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I want to write some programs for our serial console using ncurses. I
have written and tested the apps in i386, now I want to cross compile it.
I ahave Monta vista linux and ncurses is not available on i386.
When i tried to include the /usr/include/ for ncurses, ppc-gcc issues
warnings.
I downloaded ncurses-devel-5.2-12.ppc.rpm but rpm refuses to install it
on i386 because it is not for the architecture. I did not try the
--force option because of the conflicts.

How shall I get ncurses-devel-5.2-12 for ppc and install it in i386?

Thanks and regards,
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
