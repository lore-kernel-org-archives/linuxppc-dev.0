Subject: Re: porting oprofile to ppc
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Albert Cahalan <albert@users.sourceforge.net>
Cc: Segher Boessenkool <segher@koffie.nl>,
	oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <1046679297.1090.405.camel@cube>
References: <1046474835.1090.303.camel@cube>  <3E62B4C4.6030306@koffie.nl>
	 <1046679297.1090.405.camel@cube>
Content-Type: text/plain
Message-Id: <1046680119.2019.112.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 03 Mar 2003 09:28:39 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 2003-03-03 at 09:14, Albert Cahalan wrote:

> > You are talking about the time base?  It runs at 1/4th
> > the cpu clock.  It can be disabled by means of a hardware
> > pin (GPIO9 on most Mac's); default is running and that's
> > just what you want, I think ;)
>
> Yes. I wonder where I got the 1/16 idea.

Isn't it the bus clock rather ?

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
