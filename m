Message-ID: <XFMail.991218120859.jeremy@goop.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.GSO.4.10.9911251429370.12868-100000@user2.teleport.com>
Date: Sat, 18 Dec 1999 12:08:59 -0800 (PST)
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Jeffrey Karl Lassahn <jkl@teleport.com>
Subject: Re: dead code removal
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 25-Nov-99 Jeffrey Karl Lassahn wrote:
> In principle it can be if the function is marked static (so the compiler
> knows it will never link outside the module.)  Does anyone know if GCC
> does remove the code in this case?

No, only if its inline.  Just because the compiler can't see a reference, it
doesn't mean one isn't there - inline assember may refer to the static function.

Basically, you need the linker to strip dead functions, because nothing else
has enough information to do it right.

        J

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
