Mime-Version: 1.0
Message-Id: <a05010401b8973b2fb85e@[192.168.1.11]>
In-Reply-To: <Pine.LNX.4.33.0202181601100.4607-100000@gra-lx1.iram.es>
References: <Pine.LNX.4.33.0202181601100.4607-100000@gra-lx1.iram.es>
Date: Mon, 18 Feb 2002 17:18:16 -0600
To: linuxppc-dev@lists.linuxppc.org
From: Michael Heironimus <subexpression@mac.com>
Subject: Re: Final question: best wasy to move /, /usr, /home, etc?
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just a note, "cp -a" is sort of a GNU-ish thing. On most other UNIX
systems you must use tar/cpio/rsync/whatever to preserve ownerships
and permissions. Just thought I'd point that out since I've seen
people make that mistake, and it can be a pain to clean up.

At 16:05 +0100 2/18/02, Gabriel Paubert wrote:
>On Mon, 18 Feb 2002, Derrik Pates wrote:
>  > On Mon, Feb 18, 2002 at 09:42:53AM +0100, Giuliano Pochini wrote:
>>  > cp -a works fine.
>>
>>  Yeah, unless you don't care about any hard links (which a simple 'cp -a'
>>  will happily stomp all over). Using tar is a better bet (I've done it
>>  plenty of times, it works).
>
>Strange enough, cp -a does preserve hard links for me. As it should
>since -a is equivalent to -dpR and -d means (from info cp):
>
>`-d' `--no-dereference'
>      Copy symbolic links as symbolic links rather than copying the
>      files that they point to, and preserve hard links between source
>      files in the copies.
>
>I've used it often enough to be pretty sure about this feature.

--
Michael Heironimus

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
