From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Lombard Sleep Crash (Was: 2.2.18pre17 again)
Date: Thu, 2 Nov 2000 17:11:42 +0100
Message-Id: <19340927094326.6896@192.168.1.2>
In-Reply-To: 
 <Pine.LNX.4.10.10011021638110.31372-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10011021638110.31372-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Well, the kernel sleep code is supposed to take care of that, but
>> apparently, that code is also causing the panic...
>>
>> Michael, any clue ?
>
>Not at this time. My 2.2.18pre14 behaves as expected (CD inserted but not
>mounted). I'll yet have to try pre17.
>
>Side note: the ide revalidate patch is in Alan's pre18 now, so you can
>start feeding him the related wakeup patches...

Yup, I know. Paul has all the patches and will probably take care of
feeding Alan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
