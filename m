Message-ID: <39D00C41.82E2B00D@fuse.net>
Date: Mon, 25 Sep 2000 22:38:58 -0400
From: Jack Howarth <howarth@fuse.net>
MIME-Version: 1.0
To: geoffk@cygnus.com, Franz.Sirl-kernel@lauterbach.com, drepper@cygnus.com,
        libc-alpha@sources.redhat.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [RFC] IPC64 with glibc-2.2 and linux-2.4
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geoff,
      I believe I have covered all of the combination of tests you asked
about concerning
Franz's glibc 2.1.94 and Linux 2.4-test9 patches for the IPC64 issue.
Again this problem
arose when we recompiled XFree86 4.0.1 against glibc 2.1.9x. Thus I have
done the following
tests...

1) XFree86 built against patched glibc 2.1.94 with patched Linux
2.4-test9  - gnome is working now
2) XFree86 built against glibc 2.1.3 with patched Linux 2.4-test9 -
gnome is working....always did before
3) XFree86 built against patched glibc 2.1.94 with Linux 2.2.17pre20 -
gnome is working now
4) XFree86 built against glibc 2.1.3 with Linux 2.2.17pre20 - gnome is
working

I believe we are safe with Franz's proposed patch and the only question
is do we increase the seq
field to 32 bits from 16 bits.
                                                          Jack
ps Of course without Franz's patches to glibc 2.1.94 and Linux
2.4-test9, tests 1 and 3 would have
failed when I tried to run gnome.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
