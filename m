From: "Brijesh K Singh" <brijesh.ksingh@patni.com>
To: "'Linuxppc-Embedded'" <linuxppc-embedded@lists.linuxppc.org>
Subject: tcp retrans timeout!!!
Date: Fri, 12 Dec 2003 21:07:54 +0530
Message-ID: <HJEKJLMPPGBKKGCNCHOGIEGHCCAA.brijesh.ksingh@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20031212074541.A32360@home.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I have a question about TCP packet retrans timeout.

(1) How to know TCP packet retrans timeout(how long)?
(2) How to change TCP packet retrans timeout?

Thanks in advance.

Brijesh


-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Matt
Porter
Sent: Friday, December 12, 2003 8:16 PM
To: Stefan Roese
Cc: 'DaveyWu'; 'Linuxppc-Embedded'; benh@kernel.crashing.org;
akuster@mvista.com
Subject: Re: PPC4xx enet driver problem (version 2.0)



On Fri, Dec 12, 2003 at 11:56:09AM +0100, Stefan Roese wrote:
>
> Davey!
>
> No, we didn't solve this problem so far. Eugene did some tests on an
> ppc440 board and had no problems with the multiple enet devices. So it
> seems to be 405ep related! I still have to send some debug output to
> Eugene (hopefully today)!

[I haven't followed the thread but new EMAC driver and 405EP rings
 a bell]

It's possible that the new method in which OCP code handles OCP device
dependencies has a bug.  405ep is a special case since it requires
a particular EMAC device to provide MDIO operations for both EMACs.
440gp/gx don't follow this code path.

-Matt


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
