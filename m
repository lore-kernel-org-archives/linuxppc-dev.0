In-Reply-To: <3806A9A2.EC5A82D6@mondonet.net>
Date: Fri, 15 Oct 1999 10:33:38 +0200
To: Mario Scarpa <m.scarpa@mondonet.net>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: serial on lombard
Message-Id: <19991015103338.014823@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Oct 14, 1999, Mario Scarpa <m.scarpa@mondonet.net> wrote:

>>  But if mincom is the only program that is unhappy with the wait, it
>> sure is sufficient to fix minicom (and make the serial driver return
>> -ERESTARTSYS or similar if the wait was interrupted by a signal).
>
>What about chat ? Fixing it will give a lot of us the
>possibility to use PPP via command line (which I prefer
>btw :)) and, Micheal, chat seems not to work.

Could you elaborate ? With the current sleeping driver, both chat and PPP
are working just fine on my wallstreet from the command line. Is there
something wrong for you ?

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
