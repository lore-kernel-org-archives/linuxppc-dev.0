Date: Mon, 18 Feb 2002 16:05:14 +0100 (CET)
From: Gabriel Paubert <paubert@iram.es>
To: Derrik Pates <dpates@dsdk12.net>
Cc: Giuliano Pochini <pochini@shiny.it>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: Final question: best wasy to move /, /usr, /home, etc?
In-Reply-To: <20020218145256.GB5172@dsdk12.net>
Message-ID: <Pine.LNX.4.33.0202181601100.4607-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 18 Feb 2002, Derrik Pates wrote:

>
> On Mon, Feb 18, 2002 at 09:42:53AM +0100, Giuliano Pochini wrote:
> > cp -a works fine.
>
> Yeah, unless you don't care about any hard links (which a simple 'cp -a'
> will happily stomp all over). Using tar is a better bet (I've done it
> plenty of times, it works).

Strange enough, cp -a does preserve hard links for me. As it should
since -a is equivalent to -dpR and -d means (from info cp):

`-d' `--no-dereference'
     Copy symbolic links as symbolic links rather than copying the
     files that they point to, and preserve hard links between source
     files in the copies.

I've used it often enough to be pretty sure about this feature.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
