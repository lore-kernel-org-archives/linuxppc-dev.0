From: Kwanksuk Kim <kskim@neowave.co.kr>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: add-symbole-file doesn't work properly in powerpc-linux-gdb
Date: Thu, 1 Feb 2001 12:08:19 +0900
Content-Type: text/plain
References: <000501c08bdf$df460610$4d012ac7@warp-speed> <01020111314103.00751@kskim.neowave.co.kr>
In-Reply-To: <01020111314103.00751@kskim.neowave.co.kr>
MIME-Version: 1.0
Message-Id: <01020112160804.00751@kskim.neowave.co.kr>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorry, I just fount there was a problem not on debugger but compiler.

When I loaded x86 object file to gdb for powerpc (It seems symbols are
compatible) I can see the functions. but loaded ppc object file to gdb for x86
I can't see the functions.

The compiler for ppc is gcc on HHL developement kit. Of course I gave option
'-g'.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
