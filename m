From: Benjamin Herrenschmidt <bh40@calva.net>
To: <costabel@wanadoo.fr>, Paul Mackerras <paulus@linuxcare.com>,
        Linux -Dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: success 2.4.0-test8 with latest bk
Date: Wed, 13 Sep 2000 14:47:00 +0200
Message-Id: <20000913124700.2558@mailhost.mipsys.com>
In-Reply-To: <39BF773E.A5A3D298@univ-rennes1.fr>
References: <39BF773E.A5A3D298@univ-rennes1.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> > You are lucky. For me it stops booting after the "freeing unused kernel
>> > memory" line. The one from 2 days ago had 2 days uptime.
>>
>> Usually this means that some function/data is marked __init while it
>must not.
>> Quick verification: #undef __init / #define __init etc.
>>
>> Just wondering: wouldn't it be possible to write some tool to find such
>bugs?
>
>Update: After a recompilation with today's updates, the latest bk kernel
>boots again for me.

That's not the first time I notice this strange behaviour. I meant, this
happened to me randomly with various bk kernels for monthes. The problem
usually disappeared by itself after either recompiling the entire kernel,
or changing a few unrelated lines of code and then reompiling. That's
weird, I really don't know what can be causing that.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
