Message-Id: <200002091719.SAA23840@appel.flower>
To: BenH <bh40@calva.net>
cc: Dan Bethe <dan_bethe@yahoo.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: the state of the linuxppc-dev community
Date: Wed, 09 Feb 2000 18:19:27 +0100
From: Jan Nieuwenhuizen <janneke@gnu.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


BenH writes:

>  - The primary source for the "current" up-to-date kernel source tree for
> powermac
>    is Paul Mackerras rsync tree. It can be retreived with rsync:
>
>       rsync -arvz linucare.com.au::linux-pmac-stable <dest_dir>
>
>    This tree contains all the latest fixes, features, etc... as long as
> they are
>    considered stable.

Similarly, I heard some time ago, that

    rsync -auvz linuxcare.com.au::linux-pmac-devel <dest_dir>

would give me a fairly recent development (2.3.x) kernel.
Jan 14, and Feb 1, I succeeded in building a kernel (2.3.39) from that,
jippie!  But since then, I'm getting silly permission errors:

    [root@appel linux]# rsync -auvz linuxcare.com.au::linux-pmac-devel .
    Welcome to the Linuxcare Australia rsync server
    For information about Linuxcare see http://linuxcare.com.au/

    receiving file list ... done
    ./
    arch/ppc/
    send_files failed to open Documentation/kernel-docs.txt: Permission denied
    send_files failed to open Documentation/sound/NM256: Permission denied
    wrote 123 bytes  read 110685 bytes  4345.41 bytes/sec
    total size is 71388166  speedup is 644.25

Greetings,

Jan.

--
Jan Nieuwenhuizen <janneke@gnu.org> | GNU LilyPond - The music typesetter
http://www.xs4all.nl/~jantien       | http://www.lilypond.org

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
