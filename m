From: Benjamin Herrenschmidt <bh40@calva.net>
To: Scott Hankin <shankin@rational.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.0-test10 boot failure on Powerbook G3
Date: Thu, 19 Oct 2000 19:36:02 +0200
Message-Id: <19340913110746.27341@192.168.1.2>
In-Reply-To: <39EF2BC1.E464D72F@rational.com>
References: <39EF2BC1.E464D72F@rational.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>then the screen goes black, and I see
>
>vector: 300 at pc = c016d060, lr = c016c8f4, msr = 9032, sp = c07b1cc0
>[c07b1c10]
>dar = 7ac, dsisr = 40000000
>current = c07b0000, pid = 1, comm = swapper
>mon>

Can you lookup in your System.map in which functions are the PC and LR
addresses ? (pc = c016d060, lr = c016c8f4)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
