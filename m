Date: Tue, 5 Dec 2000 11:28:46 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: alex@cosmo.allay.net
cc: linuxppc-dev@lists.linuxppc.org, max@trega.com
Subject: Re: lots of questions (va_list, embedded perl, cvsd, introduction
 - sort of)
In-Reply-To: <Pine.LNX.4.10.10012050215570.22364-100000@macachu.ex-pressnet.com>
Message-ID: <Pine.LNX.4.10.10012051127020.10697-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> in the above code, buf is null. furthermore, in the second va_start-end
> clause, ap is clobbered. so putchan never has anything to "put." because
> the chassis is so thorough, i am adding it to the bottom of the message so
> my next question actually gets read. but i would really love it if people
> would take it and run it and tell me what they get.

opal:~> ./va-test
pass [1] int: 25 string: somestring
pass [2] int: 25 string: somestring
pass [3] int: 25 string: somestring
pass [4] int: 25 string: somestring
Speicherschutzverletzung (core dumped)

is what I get. On Intel, that is. gcc version is egcs-2.91.66. Seems
something's wrong with your code in general.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
