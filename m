From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Halfmann, Klaus" <khalfmann@libra.de>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: AW: Sound on an iBook?
Date: Fri, 8 Dec 2000 13:12:35 +0100
Message-Id: <19341102054419.941@192.168.1.2>
In-Reply-To: <F14441D40E5AD3118886005004607AD10BDE8C@MAIL1>
References: <F14441D40E5AD3118886005004607AD10BDE8C@MAIL1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>This issue needs a good assembler-/Forth- Programmer that must
>use MacsBug in MacOS or dissassemble the OF to find out whats
>going on there. I'd really like to do that but that is nothing
>I can do when going to work by train ..

Well, the DACA chip itself seem to be a non-Apple thing, so doc
for it may be available. The issue is more to have an i2c driver
for KeyLargo.

I don't think hacking the forth code is the easiest solution for
that ;) It's probably a lot simpler to look at Darwin driver to
figure out how the chip works ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
