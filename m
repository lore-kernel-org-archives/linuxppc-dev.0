Message-Id: <200011010733.IAA00809@piglet.grunz.lu>
Date: Wed, 1 Nov 2000 08:33:45 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 2.2.18pre17 again
To: bh40@calva.net
cc: paulus@linuxcare.com.au, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <19340925052524.13014@192.168.1.2>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  31 Oct, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>- ICTC support in the sysctl interface:
>
> Won't this require recalibrating the loops_per_jiffy for udelay() ?

In a perfect world, yes. But I have seen no ill effects of a (limited)
loops_per_jiffy mismatch.

But I agree, if you want to heavily use ICTC we'd better fix this part.
But the solution has followed ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
