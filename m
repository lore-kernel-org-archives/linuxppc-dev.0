Message-ID: <3E66DA14.C200EDC6@innomedia.soft.net>
Date: Thu, 06 Mar 2003 10:48:12 +0530
From: Anand Franklin J <franklin@innomedia.soft.net>
MIME-Version: 1.0
To: Felix Domke <tmbinc@elitedvb.net>
Cc: ppc_embedded_maillist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: reading block of data from host problem!!!!
References: <3E65B5EE.4C2A7459@innomedia.soft.net> <3E66A53E.9080608@elitedvb.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Felix
    the tftp server is working. "tftp localhost" with get zImage.treeboot
for localhost is working. still the problem exist. I don't what is the
problem.
thanking you
franklin

Felix Domke wrote:

> Anand Franklin J wrote:
> > Hello All,
> >     can any body tell what is the problem, it just hangs in reading the
> > "block 1" of zImage.treeboot and not proceeding further from tftp
> > booting process. I am using IBM power pc redwood 4.
>
> Although this isn't related to linux, this probably only means that no
> tftp server is running at all.
>
> (yes, i got this "error report" from a customer, and this was the fault)
>
> try "tftp localhost" -> "get zImage.treeboot" (or whatever) and see if
> tftp is *really* working on your tftp server machine.
>
> felix


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
