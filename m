In-Reply-To: <19990913163755.A310@them.org>
Date: Tue, 14 Sep 1999 11:15:20 +0200
To: Daniel Jacobowitz <drow@false.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: hfs resource forks in Linux
Message-Id: <19990914111520.021034@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Sep 13, 1999, Daniel Jacobowitz <drow@false.org> wrote:

>Not quite what I was talking about.  These let us touch the resource
>fork, and deal with hfs volumes, not manage a specific file's resource
>fork on the resource level.

The resource fork format is not terribly complex. If noone does it, I'll
look into writing a couple of tools for managing them one of those days.


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
