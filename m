Message-ID: <24019-11838@sneakemail.com>
Date: Thu, 11 Mar 2004 20:44:09 -0800
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [RFC] "indirect" DCR access (40x, BookE)
References: <20040312014800.GA25455@gate.ebshome.net> <405124A3.3040002@embeddededge.com> <20040312030502.GA25644@gate.ebshome.net>
In-Reply-To: <20040312030502.GA25644@gate.ebshome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Eugene Surovegin ebs-at-ebshome.net |PPC Linux Embedded| wrote:
> On Thu, Mar 11, 2004 at 09:46:59PM -0500, Dan Malek wrote:
>
>>>Comments, suggestions are welcome.
>>
>>I think you should just write it as self modifying code :-)
>>Write the instruction with the DCR number and just execute it.
>
>
> And deal with locking and icache/dcache coherency ?
>
> No, thanks :)


Actually, I recall that there is a code fixup mechanism that
is invoked early in kernel init that does exactly that: it
manages some machine specific differences by editing the code
in place in a safe way. My memory is not good enough to point
to the right place in the code, though, or to explain how it
works.

--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
