In-Reply-To: <37F241DB.94C9BF00@chpc.utah.edu>
Date: Wed, 29 Sep 1999 19:02:22 +0200
To: Lou Langholtz <ldl@chpc.utah.edu>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: [Fwd: Bug: 2.2.12 still hangs PPC after some PPP activity]
Message-Id: <19990929190222.023648@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Sep 29, 1999, Lou Langholtz <ldl@chpc.utah.edu> wrote:

>This is pretty much the kernel I'm running now. I haven't had the "FB.
>overflow"
>message yet nor system-freeze but I've experienced the TCP slowdown already.
>Evidence that we've got other problems as well (IMO). It's only been 20 hours
>or
>so with new kernel so not enough time for me to feel confident though about
>these
>results.

I've added another fix to the kernel on my test page
(http://calvaweb.calvacom.fr/bh40/test.html). It may fix the hang on
close. I don't think it will fix anything related to a slowdown however.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
