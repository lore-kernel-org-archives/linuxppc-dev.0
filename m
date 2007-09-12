Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <AC5C6EF4-EE8E-487F-BF45-3653A5C2617D@kernel.crashing.org>
References: <Pine.LNX.4.64.0709111436290.14121@blarg.am.freescale.net>
	<20070912031132.GC20218@localhost.localdomain>
	<AC5C6EF4-EE8E-487F-BF45-3653A5C2617D@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <cbff3b332b53f61721a8e14472347b98@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
Date: Wed, 12 Sep 2007 16:10:09 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +					i8259: interrupt-controller@20 {
>>> +						reg = <1 20 2
>>> +						       1 a0 2
>>> +						       1 4d0 2>;
>>> +						clock-frequency = <0>;
>>
>> Hrm.. what is clock-frequency for on an i8259?  I see that other 8259
>> descriptions have this as well, so it's not a problem with this patch
>> specifically.
>
> Its a copy-paste thing so I don't know.

If your bootwrapper doesn't fill in this value, you should get rid
of this property -- better to have no value than to have the wrong
value, esp. since it's probably unused anyway.


Segher
