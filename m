Date: Mon, 18 Feb 2002 07:52:56 -0700
To: Giuliano Pochini <pochini@shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Final question: best wasy to move /, /usr, /home, etc?
Message-ID: <20020218145256.GB5172@dsdk12.net>
References: <20020218021717.EDHQ21433.tomts12-srv.bellnexxia.net@there> <XFMail.20020218094253.pochini@shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <XFMail.20020218094253.pochini@shiny.it>
From: dpates@dsdk12.net (Derrik Pates)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Feb 18, 2002 at 09:42:53AM +0100, Giuliano Pochini wrote:
> cp -a works fine.

Yeah, unless you don't care about any hard links (which a simple 'cp -a'
will happily stomp all over). Using tar is a better bet (I've done it
plenty of times, it works).

--
Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
