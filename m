Message-Id: <4.2.2.19991130110534.00b563b0@mail.lauterbach.com>
Date: Tue, 30 Nov 1999 11:58:19 +0100
To: Jason Kim <jwk2@EECS.Lehigh.EDU>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: patch for problem with va-ppc.h included with egcs and
  gcc-2.95.2
Cc: linuxppc-dev@lists.linuxppc.org, gcc-patches@gcc.gnu.org
In-Reply-To: <38436801.81D6CE60@eecs.lehigh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 07:00 30.11.99 , Jason Kim wrote:
>Agreed, ssh2 code isn't necessarily the cleanest in the world, but then again
>the varargs situation in PPC world is a bit peculiar.
>
>
>typedef struct A {
>   char foo;
>   char *bar;
>} B[1], C[1];
>
>typedef C D;
>
>
>void tst(D d1)
>{
>   D d2;
>   d1 = d2; // this is legal
>   // d2 = d1; // this is not
>}
>
>declaring arrays of fixed size seems a bit strange for a type which will 
>be used
>by user code, since it makes d1 and d2 be different types sometimes. Not to
>mention, having struct _va_list_tag  AS va_list seem to fix the problems 
>neatly.
>
>Is there a technical reason for keeping va_list as an array of 1 element?
>(instead of just a single element??)

1. this behaviour is mandated by the ABI
2. it nicely spots a common programming error

I see nothing peculiar about it :-).

BTW, it would be nice if you could fix your spam filter, my last message 
was rejected, even though there was no faked IP in it.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
