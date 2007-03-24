Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1174679208.10836.71.camel@localhost.localdomain>
References: <1174544624.10836.24.camel@localhost.localdomain>
	<94d8e19d4b061504fcfd08d1ab70cc78@kernel.crashing.org>
	<20070323120619.GA7472@localhost.localdomain>
	<94FD59E6-B618-4AB2-9BAB-D40A70CC1589@kernel.crashing.org>
	<b7160f3020aae6e7926b79c14939750c@kernel.crashing.org>
	<1174679208.10836.71.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <6df7c98b19ded7a8a006e375255e3c3f@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] force -mno-string option on cell
Date: Sat, 24 Mar 2007 01:04:40 +0100
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Akinobu Mita <mita@fixstars.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> In the absence of -mstring and -mno-string options,
>> GCC will default to either on or off based on other
>> options (CPU model, mostly).  This is good behaviour
>> since it intends to give you the best code sequences
>> for whatever CPU you selected (or for a blended CPU
>> model etc).
>
> strings instructions suck, get away with it.

No they don't.

End of this particular subthread I suppose, heh.


Segher
