To: linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128fb.c missing from rync'd benh sources...
References: <20010726200759.A19851@garmonbozia.productivitynet.com>
	<20010726200901.C8790@localhost.localdomain>
From: Daniel Berlin <dan@cgsoftware.com>
Date: Thu, 26 Jul 2001 21:08:32 -0400
In-Reply-To: <20010726200901.C8790@localhost.localdomain> (Ethan Blanton's message of "Thu, 26 Jul 2001 20:09:01 -0400")
Message-ID: <87elr3xjov.fsf@cgsoftware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ethan Blanton <eblanton@cs.ohiou.edu> writes:

> Armando Di Cianno spake unto us the following wisdom:
>> I did an rsync to penguinppc.org::linux-2.4-benh at approx 7/26/01 8 PM
>> EST.
>
> I just rsync'd (8:07PM EST) and it's there.

No, he's right, you are wrong.
You just aren't using the --delete flag, so it never deleted the file.

>
>> 'make vmlinux' fails in the video directory complaing it is not able to
>> find aty128fb.o.  I checked in drivers/video and there is no aty128fb.c
>> file anymore; I re-rsynced to make sure it wasn't my incompetence.
>>
>> Since the benh kernel tends to be my 'favorite', I'd like to get my TiBook
>> re-rsynced whenever possible.  Is there any reason this file was removed,
>> or was it a mistake?
>
> Ethan
>
> --
> If I've told you once, I've told you once
> And once is all that you needed.
> 		-- The Refreshments, "Carefree"

--
"I was in the grocery store.  I saw a sign that said "pet
supplies."  So I did.  Then I went outside and saw a sign that
said "compact cars"...
"-Steven Wright

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
