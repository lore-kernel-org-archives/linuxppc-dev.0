Date: Tue, 16 Apr 2002 07:59:09 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: 9600 maturity?
To: benh@kernel.crashing.org
Cc: dan_bethe@yahoo.com, nicoya@apia.dhs.org,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20020415091958.19056@smtp.wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E16xLzp-00008q-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


'Morning,

On  15 Apr, this message from Benjamin Herrenschmidt echoed through cyberspace:
>>No, 2.4 kernels should have solid PCI even in the presence of multiple
>>host bridges (which was the problem on the dual-bandit 9x00). The only
>>potentially remaining problem could be access to IO space on the second
>>bus. Ben, can you comment?
>
> I can't. I would love having someone try this in details and tell me ;)
>
> I suspect the second bandit can only produce "high" IO addresses (thus
> precenting use of legacy stuff).

But is there something in place now in the PCI code to handle the IO
space of multiple host bridges now? When I was working on the chaos PCI
code, you had plans to implement that part...

IIRC, you wanted to move both IO spaces into a continous segment and
provide some way to find the ber-bus base of IO space...

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
