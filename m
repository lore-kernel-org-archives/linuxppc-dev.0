Message-ID: <3CBD9361.4060203@cymes.de>
Date: Wed, 17 Apr 2002 17:23:13 +0200
From: Matthias Grimm <joker@cymes.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: muteing speakers if headphones were plugged in?
References: <3CBC59C0.7000505@cymes.de> <20020416173026.16606@smtp.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

>>I don't know where to get the information if headphones are plugged in
>>or not, so I had a look into the recent kernel and I saw some code (for
>>eg. headphone_intr() ) that seems to do what I am asked for. On the
>>other hand the code seems very experimental and not really complete as I
>>could see at some comments.
>>
>>What is the status? Should this feature (muting the speakers ...) be
>>part of the kernel or was it only a fast shot to get it work?
>>
>
> It works with recent drivers though only if your chipset is Tumbler afaik.


Is someone working on that issue to implement it for the other chipsets?

  Matthias


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
