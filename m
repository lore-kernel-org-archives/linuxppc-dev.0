Message-Id: <4.2.2.19991201162019.03c111b0@mail.lauterbach.com>
Date: Wed, 01 Dec 1999 16:33:30 +0100
To: Jason Kim <jwk2@EECS.Lehigh.EDU>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: patch for problem with va-ppc.h included with egcs and
  gcc-2.95.2
Cc: "gcc-patches@gcc.gnu.org" <gcc-patches@gcc.gnu.org>,
        "linuxppc-dev@lists.linuxppc.org" <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <38445DB4.8E8E86CB@eecs.lehigh.edu>
References: <4.2.2.19991130110534.00b563b0@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 00:28 01.12.99 , Jason Kim wrote:
>Also, in the ANSI C (9x) documentation (``n843''), taking the address of a
>va_list is NOT listed as one of the things that will produce an undefined
>result. Actually, on page 7.15 (pg246 as seen by acroread), footnote item 198
>specifically states ``It is permitted to create a pointer to a va_list and
>pass that pointer to another function,.. in which case the original list may
>make further use of the original list after the other function returns.''

Well, I see this is also in ISO C9x, but unless the standard restricts the 
possible types for va_list (I can't find anything about that), you have 
still to be aware that any callee gets a reference to the va_list if 
va_list is an array and so the usual array handling rules apply, or?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
