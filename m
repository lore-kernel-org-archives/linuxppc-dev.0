Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3C9A35AB.9080701@embeddededge.com>
Date: Thu, 21 Mar 2002 14:34:03 -0500
From: Dan Malek <dan@embeddededge.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>
Cc: "Kerl, John" <John.Kerl@Avnet.com>,
	LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC8xx, FEC and DP83847 !?
References: <C08678384BE7D311B4D70004ACA371050B763346@amer22.avnet.com> <3C9A1F5C.61673202@imc-berlin.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Steven Scholz wrote:

>> The Motorola reference boards use port D for MII, but we
>> used PCMCIA/port A pins instead.
>
>
> Why would you probably do this?

If someone is doing this, please send me some patches for the
driver when you get it working.  All of the 857s I have seen
are still using Port D for the FEC.  I guess I could make the
changes if someone else can test them.

> I supposed you're using PORT D for something else!?

The intention is to also be able to use Port D for the ATM UTOPIA
so you can have 10/100 and ATM on the same part.  This is really
the purpose of the 857, although I have yet to see anyone use it
that way :-).


	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
