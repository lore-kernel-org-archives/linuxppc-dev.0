Date: Sun, 17 Jan 1999 17:47:18 +1100
Message-Id: <199901170647.RAA02619@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: thedrick@netspace.org
CC: linuxppc-dev@lists.linuxppc.org
In-reply-to: <Pine.LNX.4.05.9901150212250.26871-100000@netspace.org> (message
	from Ty Hedrick on Fri, 15 Jan 1999 02:27:54 -0500 (EST))
Subject: Re: Powerbase IDE: DMA & ohare-ata
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <Pine.LNX.4.05.9901150212250.26871-100000@netspace.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ty Hedrick <thedrick@netspace.org> wrote:

> It seems that even though the Powerbase is perfectly capable of DMA, the
> test in ide-pmac.c to setup DMA 
> 
> #ifdef CONFIG_BLK_DEV_IDEDMA_PMAC
>                 if (np->n_addrs >= 2 && np->n_intrs >= 2) {
> 
> fails because n_intrs is 0.  Risking my mostly worthless IDE drive I

Could you get a copy of lsprop (ftp://samba.anu.edu.au/pub/linux-pmac/misc)
and do `lsprop /proc/device-tree/bandit/ohare/ide' (or whatever the
node for your IDE controller is called) and send it to me?

In fact we don't use the DMA interrupt, so the test for np->n_intrs
could be removed.

Paul.

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
