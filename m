MIME-Version: 1.0
Message-Id: <38DB3B3A.16284@mta5>
Date: Fri, 24 Mar 2000 17:54:02 +0800 (CST)
From: "zzh" <david-1z@263.net>
To: <linuxppc_em@sina.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re:Re: About rs232 on motorola mpc8260 ads board
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
>----- Original Message -----
>From: zzh <david-1z@263.net>
>To: <linuxppc-embedded@lists.linuxppc.org>
>Sent: Wednesday, March 22, 2000 4:28 PM
>Subject: About rs232 on motorola mpc8260 ads board
>
>
>>
>> Hello,everyone.
>> I'm trying to make the SCC1 drived rs232 port of a motorola
>> mpc8260 ads board work.The manual says it can direct connect
>> to pc com port.But it seems the output from this board is not
>> rs232 voltage.i.e -3 to -12 for logical one,3 to 12 for logical
>> zero,nor is it TTL,it seems that it use 0 for logical 1,5.0v for
>> logical 0,so it is rather annoying. I have to invert the output
>> from 8260 ads,then use a TTL->232 converter to connect with PC,
>> it works when i send char from 8260,but cannot work in the
>> other direction.
>> In addition,for a while,it output 232 signal,but i cannot
>> reproduce it!!
>> Does anyone has experience with this board?
>> Thanks for your advice.
>>                     davidzhang
>>                     3/22/2000
>>
>> _____________________________________________
>> 首都在线--中国人的网上家园 http://www.263.net
>> @263.net中国最大的在线邮局 http://freemail.263.net
>>
>
>
>Pavel Roskin is right , that means to check RTS(from ads) or enable it manually.
>
Have you hack with this board?today i check the manual,find that it
has SCC1 RTS connect to rs232 CTS pin (pin 8),the init8260 program
from motorola did not init this pin(PD29).Should i program this pin?
How should i make the pin connection.For now,i connect DSR with DTR,
Tx with PC Rx,Rx with PC tx.Most amazing to me is that when i measure
the output wave from Tx pin,it is 0-5V.what it looks like when i
output a 'c' (0x63 which is 01100011) is as below:
    start  11    000      11   0   (lsbit to msbit)
5v    ---      ---------      ---

0v  --   ------         ------
All will be  right if 0v is -3 to -12 and 5v is 3 to 12
What wrong with this?
>b.r.
>john zhan.
>hacking time.
>
>
>
>


_____________________________________________
首都在线--中国人的网上家园 http://www.263.net
@263.net中国最大的在线邮局 http://freemail.263.net

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
