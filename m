From: Keith Owens <kaos@ocs.com.au>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: include/asm-ppc/platforms/ 
In-reply-to: Your message of "Tue, 27 Nov 2001 08:22:44 PDT."
             <20011127082244.I13091@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 28 Nov 2001 13:35:54 +1100
Message-ID: <9487.1006914954@kao2.melbourne.sgi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 27 Nov 2001 08:22:44 -0700,
Tom Rini <trini@kernel.crashing.org> wrote:
>I sort of like the include/asm-ppc/platforms symlink idea, but I forget
>if kbuild-2.5 works well with this or if it is/was painful.  Keith?

It is only painful it you want to generate files in that directory at
compile time, you have to jump through hoops to prevent the files being
written to the source tree when source and object are seperate
directories.  Symlinks for read only files are not a problem.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
