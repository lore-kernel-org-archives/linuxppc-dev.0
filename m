From: "Hendricks, Kevin" <khendricks@ivey.uwo.ca>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-Id: <v03110702b5a7508b3a75@[129.100.29.243]>
In-Reply-To: <4.3.2.7.2.20000728154143.03925220@mail.lauterbach.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 28 Jul 2000 11:01:01 -0400
Subject: Re: Fwd: problems with linuxthreads under your latest glibc 15C  
 rpms
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Thanks Franz!

Kevin


>Hi,
>
>this is a heads-up notice for distribution maintainers using the
>glibc-2-1-branch. It seems the branch contains a threads bug introduced with:
>
>2000-03-16  Ulrich Drepper  <drepper@redhat.com>
>
>         * mutex.c (__pthread_mutex_lock): Always initialize __m_owner.
>         (__pthread_mutex_trylock): Likewise.
>         (__pthread_mutex_unlock): Always clear __m_owner.
>
>Check the appended message for details. I've added the patch to my source
>tree, maybe someone finds time to check it in into the branch (yes, I know
>that the branch is more or less dead :-) ).
>
>Thanks,
>Franz.
>

--
Kevin B. Hendricks, Associate Professor of Operations and Information
Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
