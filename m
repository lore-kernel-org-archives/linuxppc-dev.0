Message-ID: <3E64212F.3080309@koffie.nl>
Date: Tue, 04 Mar 2003 04:44:47 +0100
From: Segher Boessenkool <segher@koffie.nl>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
	oprofile-list@lists.sourceforge.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: porting oprofile to ppc
References: <1046474835.1090.303.camel@cube>  <3E62B4C4.6030306@koffie.nl>	 <1046679297.1090.405.camel@cube> <1046680119.2019.112.camel@zion.wanadoo.fr>
In-Reply-To: <1046680119.2019.112.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
> On Mon, 2003-03-03 at 09:14, Albert Cahalan wrote:
>
>
>>>You are talking about the time base?  It runs at 1/4th
>>>the cpu clock.  It can be disabled by means of a hardware
>>>pin (GPIO9 on most Mac's); default is running and that's
>>>just what you want, I think ;)
>>
>>Yes. I wonder where I got the 1/16 idea.
>
> Isn't it the bus clock rather ?

Yes, the cpu bus clock.  Sorry about the confusion.


Segher


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
