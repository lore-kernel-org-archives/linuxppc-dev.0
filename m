Message-ID: <383C8C6B.97F4CF60@kerbango.com>
Date: Wed, 24 Nov 1999 17:10:03 -0800
From: Jim Reekes <reekes@kerbango.com>
Reply-To: reekes@kerbango.com
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: dead code removal
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have a little program that contains a routine DummyFunc() which is
never reference in the code. Building this single source file in any way
I've tried results in a binary which contains DummyFunc(). Using nm and
objdump, as far as I can determine GCC 2.95 does not dead-code strip.
(which I find amazing!). So I have two questions.

Am I missing something and GCC actually does dead-code stripping?

 - or - 

How can I find unused/unreferenced symbols in my code so that I can bury
the dead code manually?


Jim

P.S. I have always compared programming to ditch digging, and now I'm
convinced.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
