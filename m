Date: Tue, 14 Sep 1999 11:10:53 +0200
To: Andreas Bogk <andreas@andreas.org>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: New booter
Message-Id: <19990914111053.003150@mailhost.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Sep 13, 1999, Andreas Bogk <andreas@andreas.org> wrote:

>> I forgot to mention that the kernel args can be changed by editing the
>> CMDL resource in the System file with resedit. Don't forget the trailing
>> 0, it's a C string !
>
>What's the point of a boot application that works without MacOS when
>yu need MacOS to modify the kernel args?

Hey, wait ! This is just a first prototype ;-)

Hopefully, when finished, all those infos will be in a separate text
file. I also need to make some kind of installer that lays out the small
HFS partition, fills the boot blocks and mark the root directory
"blessed" (in MacOS terminology, that means it contains a valid System file).

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
