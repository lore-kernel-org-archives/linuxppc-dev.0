Message-Id: <199909151707.MAA16408@lists.linuxppc.org>
Date: Wed, 15 Sep 1999 13:05:10 -0400 (EDT)
From: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Reply-To: Kevin_Hendricks <khendricks@admin.ivey.uwo.ca>
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
To: mlan@cpu.lu, ldl@chpc.utah.edu
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Just to add fuel to the fire (although I am not sure if this is related or not)

My B+W G3 rev2 with 16MB of vram has never ever detected the correct amount.  In 
fact, if I run Xconfigurator, it tells me I have less then 1MB of vram and 
therefore won't let me use any of the higher resolutions that should work.

The interesting thing is that if I change my bpp via the MacOS, Xconfigurator 
reports completely different amounts of vram available and not in any logical 
way that I can see.

Any fixes along these lines would be greatly appreciated (this is with Paul's 
2.2.10 stable kernel available from his website).

Just thought someone in the know should be told :-)

Kevin



>> Hmm... official 2.2.12 does detect my 4 MB... and this is a 7600, so the same
>> motherboard as the 7500...
>>
>> Michel . . .
>
>Odd. I thought I tried stock 2.2.12 and it didn't detect the 4MB VRAM in my
>PowerMac 7500. Now I'm not so sure. A quick diff of the kernel controlfb.c 
sources
>between 2.2.6 and 2.2.12 reveal no difference though in the VRAM bank check 
code
>though so it also seems to me that if people had this problem in 2.2.6 then 
2.2.12
>should also be unable to detect the full 4MB VRAM. If you're saying that the
>hardware should be identical then could some other software be responsible such 
as
>the OF software be perhaps different and causing this different behavior? I'd
>really like some confirmation now that others with 7500 don't get all
>4MB VRAM detected even using stock 2.2.12. I've read postings from others that
>they didn't get 4MB VRAM detected but I don't think that was with 2.2.12 at 
that
>time.
>

--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA   
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
