Date: Tue, 14 Sep 1999 11:18:17 +0200
To: Ethan Benson <erbenson@alaska.net>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: New booter
Message-Id: <19990914111817.004706@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Sep 13, 1999, Ethan Benson <erbenson@alaska.net> wrote:

>>What a week, quik got fixed, AND a new booter for OF-deficient machines to
>>free them from needing MacOS just to bootstrap Linux!
>
>quik is not fixed totally, the first stage loader still does not work 
>on newworld macs, unless anyone has some suggestions...

I agree this is not perfect, but as I wrote you privately, we can still
use a small HFS partition with the second stage bootstrap beeing directly
loaded by OF. This works now, I tested it last week. Not perfect, but
better than BootX for those machine since the kernel will now be able to
use RTAS ;-)

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
