In-Reply-To: <v04003a01b3a015eadcd9@[17.203.21.242]>
Date: Wed, 30 Jun 1999 21:28:59 +0200
To: Kevyn Shortell <kevyn@apple.com>, linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: LinuxPPC R5 on PowerBook Series 1999
Message-Id: <19990630212859.015953@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jun 30, 1999, Kevyn Shortell <kevyn@apple.com> wrote:

>In response to the backlight being off....
>
>Have you tried the brightness button on the keyboard? This worked for me =)

Ok, so that means that the only thing that is wrong is reading the
current backlight value from nvram. I beleive the nvram layout did change
with NewWorld, or the PMU now stores the value like it did with the 3400.
I'll check this as soon as I can put my hand on one of those machines.

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
