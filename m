Mime-Version: 1.0
Message-Id: <a05111b01b926b4516f30@[10.0.0.42]>
In-Reply-To: <20020606232543.C9152@plato.local.lan>
References: <20020606052443.A21838@pants.nu>
 <20020606132356.B9152@plato.local.lan>
 <a05111b00b92592a276c0@[10.0.0.42]> <20020606232543.C9152@plato.local.lan>
Date: Fri, 7 Jun 2002 12:16:31 -0700
To: Ethan Benson <erbenson@alaska.net>,
	linuxppc-dev@lists.linuxppc.org, linux-fsdevel@vger.kernel.org
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: HFS+ support (read-only)
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:25 PM -0800 6/6/02, Ethan Benson wrote:
>On Thu, Jun 06, 2002 at 03:50:31PM -0700, Timothy A. Seufert wrote:
>>  The OS needs
>>  a database of all files that are hardlinked, with full reverse
>>  mappings, so that whenever a file with hardlinks is unlinked it has
>>  enough information to replace one of the hardlinks with the real file.
>
>i don't know about that, maybe.  to be honest it would not surprise me
>if apple just let that break.

Oh, come on.  :)  I just tested it, they didn't let it break.

>>  (For efficiency I'd want a flag bit in the metadata of each file to
>>  indicate that it has been hardlinked, to avoid searching the table
>>  when deleting files that have no hardlinks.  For even more
>>  efficiency, a direct pointer to the table entry.)
>
>you cannot use the word efficient to describe this puke inducing
>kludge.  the efficient way is to design the filesystem properly to
>begin with, which apple did not do with HFS+.

The kludge part is trying to retrofit features like hardlinks into a
FS which wasn't designed to naturally support them (as classic UNIX
inode FS designs do).  Aside from that I see nothing wrong with the
basic design of HFS+.

--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
