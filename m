From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Fwd: Re: More with Mozilla and glibc
Date: Sat, 11 Sep 1999 13:28:52 -0400
Content-Type: text/plain
MIME-Version: 1.0
Message-Id: <99091113302601.02027@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




----------  Forwarded Message  ----------
Subject: Re: More with Mozilla and glibc
Date: Sat, 11 Sep 1999 08:49:01 -0400
From: Kevin Hendricks <khendricks@ivey.uwo.ca>


On Sat, 11 Sep 1999, you wrote:
> Wow.  Well, I'm still thinking that my Mozilla problem is glibc related, even if
> the gdb output is bogus  ; ). 

You may be right.  The native threads jdk works with glibc 2.1.1 and won't work
with glibc 2.1.2 since they made some new semaphore functions.  I do not
recommend using glibc 2.1.2 yet for native threads stuff until they get the new
semaphore functions fixed.
'
Kevin


Has anyone else run into problems with the glibc 2.1.2 new semaphore functions?

Has glibc 2.1.2 been officially released yet and if so where can I download the
offical glibc 2.1.2 source to look at these new semaphore functions.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
