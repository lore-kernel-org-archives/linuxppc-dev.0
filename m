From: Benjamin Herrenschmidt <bh40@calva.net>
To: Henry Worth <haworth@ncal.verio.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: [RFC] DMAsound 2.4.0-tx => 2.2.17 back-port.
Date: Fri, 25 Aug 2000 00:26:49 +0100
Message-Id: <19031231222033.32301@192.168.1.10>
In-Reply-To: <Pine.SOL.4.10.10008241833460.15454-100000@ncal.verio.com>
References: <Pine.SOL.4.10.10008241833460.15454-100000@ncal.verio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Opps, yes that fixes the problem, except for the LE case. BTW,
>I couldn't find the awacs stuff in my last darwin xnu download,
>has it moved out of the xnu projects, or did I just get lost?

It's now a loadable kernel module, you can find it in the IO branch of
the CVS instead of System

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
