Message-Id: <199812210625.OAA10870@mule.wantree.com.au>
Subject: Re: undefined symbol: _IO_2_1_stdin_
Date: Mon, 21 Dec 1998 16:55:05 +1030
From: Keith Jacob <kjacob@wantree.com.au>
To: "Martin Costabel" <costabel@wanadoo.fr>
cc: "linuxppc-dev list" <linuxppc-dev@lists.linuxppc.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 20/12/98 8:09 PM, Martin Costabel <costabel@wanadoo.fr> tapped out:

>
>Keith Jacob wrote:
>> 
>> Any clues? Please?
>> 
>> Full errror is
>> 
>> error in loading shared libraries
>> : undefined symbol: _IO_2_1_stdin_
>> 
>> When?
>> 
>> Whenever I try to run pre-compiled binaries (mostly from stock LinuxPPC
>> RPMs) from late-1998 builds.
>
>Are you trying to run R4.1 binaries with R4 libraries? 

Not that I know of; certainly not intentionally.

>This won't work.
>You have to upgrade your glibc (and everything else). Better wait for R5
>and stay with binaries linked with glibc-961212 (if you can find out
>which ones they are :-)).
>
>I am pretty sure this(*) will be one of the very FAQs over the next
>months. That's why I kept the excessive crossposting list from Keith's
>original. I would love to be wrong on this. 

Excessive crossposting? What else are these lists for? (-:
>
>> 
>> BTW, Gary Thomas's latest egcs-1.1-1b RPMs include bins that exhibit this
>> behaviour, e.g. gcc!
>
>This is very strange. So maybe your problem is something else, after
>all.
>
>(*) A typical variant for pre-R5 binaries is:
> error in loading shared libraries
>: undefined symbol: __libc_start_main
>
>--
>Martin

After a *lot* more digging around, I can only assume this is actually a 
header problem, i.e. binaries compiled against the wrong headers will 
give this error message. But, as usual, the normal caveats apply; e.g. do 
I really know what I'm talking about...


--
Keith Jacob
kjacob@wantree.com.au




[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
