Message-Id: <v04003a00b46b4a1f735f@[216.81.25.5]>
In-Reply-To: <m11tDzU-0000WVC@tri-yann.crf.canon.fr>
References: <XFMail.991201105013.gdt@linuxppc.org> (message from Gary
 Thomas	on Wed, 01 Dec 1999 10:50:13 -0700 (MST))
 <XFMail.991201105013.gdt@linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 1 Dec 1999 15:59:19 -0600
To: "VALETTE Eric" <valette@crf.canon.fr>
From: Tony Mantler <eek@escape.ca>
Subject: Re: PPC Compiler Problem?
Cc: linuxppc-dev@lists.linuxppc.org, alois_fertl@muenchen.europe.mcd.mot.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:56 AM -0600 12/1/99, VALETTE Eric wrote:
[... snip ...]
>
>Where do you see long long in the example???

Watch the commas:

>extern int foo(long, long, long, long long, long);

5 args, not 6. arg 4 is a long long.


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
