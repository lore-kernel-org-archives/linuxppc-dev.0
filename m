From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Etsushi Kato <ekato@ees.hokudai.ac.jp>
Cc: <paulus@samba.org>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: tlbia and PPC603
Date: Thu, 20 Jun 2002 11:12:13 +0200
Message-Id: <20020620091213.4502@smtp.adsl.oleane.com>
In-Reply-To: <20020620193505D.ekato@ees.hokudai.ac.jp>
References: <20020620193505D.ekato@ees.hokudai.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Your xmon trace show something interesting: xmon itself crashes with a
>> trap 300 while trying to access the hash table. The hash beeing mapped
>> with a BAT, that shouldn't be an issue with the TLB handlers nor with
>> a stale TLB entry. I currently fail to see what could be going on there,
>> could you try to reproduce that crash ? In this case, once "h" fails
>> within xmon, type
>>
>>  di %pc
>
>>mon di %pc

Hrm... I should think before replying !

It's completely normal that "h" crashes on a 603 as there is simply no
hash table on this CPU.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
