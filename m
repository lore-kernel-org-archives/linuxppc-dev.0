Message-Id: <200002212049.OAA08214@lists.linuxppc.org>
Date: Mon, 21 Feb 2000 15:45:54 -0500 (EST)
From: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Reply-To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: Re: Xpmac.rage128.usb.rev9 USB problems
To: linuxppc-dev@lists.linuxppc.org, jackal@aol.net
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

AFAIK, this is a usb driver issue and has nothing to do with Xpmac.  Xpmac gets
its key events from the console device.

Please check out the usb and console drivers in the kernel for solutions to this
issue.

Kevin


>Was a fix created for this?
>
>Or should I just drop back to the older version of X?
>-b
>
>
>On Tue, 1 Feb 2000, brad allison wrote:
>
>> On Tue, 25 Jan 2000, Stephen Edie wrote:
>>
>> > Hmm,
>> >
>> > > But I'm only pressing a maximum of _two_ keys "cd" and it's coming out as
>> > > "cdcd".
>> > >
>> > > It's a real pain cause I do "cd" a lot.
>> >
>> > You are probably hitting three keys:  "cd<space>"  Anyway, this problem
>> > occurs at the console as well as in X, however, strangely it is much worse
>> > at the console.
--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
