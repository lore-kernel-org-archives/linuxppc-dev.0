Message-Id: <v03110703b5b8b78dd59f@[216.209.101.72]>
In-Reply-To: <3992F340.F9F6314B@motorola.com>
References: <3992EAE6.27CF4490@motorola.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Thu, 10 Aug 2000 15:51:28 -0400
To: Jeffrey Hawkins <Jeffrey.F.Hawkins@motorola.com>,
        Jeffrey Hawkins <Jeffrey_Hawkins-CJH016@email.mot.com>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: Re: PPC Versions of Glibc and GCC Status
Cc: Franz.Sirl-kernel@lauterbach.com, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

In case you were wondering, that patch has now (just today) been officially
added to the glibc 2.1 branch of the official glibc cvs tree.  The patch in
question prevents a race in setting the onwer to null on a mutex that
resulting in tests in condvar.c to fail about the owner of the mutex not
being the same as the caller of the thread (when it actually was).

With this in place, the JDK native threads now seem to work well.

Please let me know if this sodesn't fix your problems (I am always
interested in the linuxthreads library when tracking down jdk failures).

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
