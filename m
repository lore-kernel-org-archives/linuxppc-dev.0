Date: Fri, 28 Jan 2000 21:10:54 -0600 (CST)
From: scott hutinger <srh@www.mprojects.wiu.edu>
To: Kevin Hendricks <khendricks@ivey.uwo.ca>
cc: linuxppc-dev@lists.linuxppc.org,
        scott hutinger <srh@www.mprojects.wiu.edu>
Subject: Re: Bug in glibc 2.1.3 linuxthreads in pthread_cond_timedwait_relative
In-Reply-To: <00012814481500.18396@localhost.localdomain>
Message-ID: <Pine.LNX.3.95.1000128210239.1756B-100000@www.mprojects>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Kevin,

Yes!  I would like to keep it in the realm of what people download :-)  So
I don't need to do a build that takes all night on a 8100.

Thanks much, as always, you come through with a fix !!!!

scott

On Fri, 28 Jan 2000, Kevin Hendricks wrote:

> Hi,
>
> If you are using Franz Sirl's glibc 2.1.3 0k or 0l rpms and are seeing funny
> hangs with linuxthreads programs, here is a small patch to fix the problem of
> restarting pthread_cond_timedwait_relative_new with the same timeout and not
> remaining time.
> (see my earlier problem report).
>
> The patch file is attached:
>
> Kevin
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
