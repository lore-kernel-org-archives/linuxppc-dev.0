Message-ID: <40235240.9020406@ru.mvista.com>
Date: Fri, 06 Feb 2004 11:37:20 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Which kernel tree
References: <10045-28297@sneakemail.com> <20040206031101.GB6578@gate.ebshome.net> <325-38173@sneakemail.com>
In-Reply-To: <325-38173@sneakemail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Stephen Williams wrote:
> OK, so that means I'm going to have to get accustomed to
> bitkeeper. That'll be slightly interesting. (Grr..)
>

You can use something like
rsync -az --delete source.mvista.com::linuxppc-2.4 linuxppc-2.4
to download the tree.

Andrei


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
