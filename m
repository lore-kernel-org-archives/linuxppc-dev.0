Subject: Re: NFS root thru PPP
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: =?ISO-8859-1?Q?M=E9sz=E1ros?= Lajos <ludwigm@siemens.hu>
Cc: Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <37D0F88E70D96C428C19EEB865701A38010AD0F1@buda902a.siemens.hu>
References: <37D0F88E70D96C428C19EEB865701A38010AD0F1@buda902a.siemens.hu>
Content-Type: text/plain; charset=ISO-8859-1
Date: 28 Aug 2002 13:46:43 +0200
Message-Id: <1030535203.28699.10.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2002-08-26 at 17:22, Mészáros Lajos wrote:
>
> Have anybody experience with NFS root using PPP ?
>
> I have ported 2.4.18 kernel to a factory developed 850 board.
> It has two serial port but no ETH (the next version will have one).
> How can I use the 2nd serial as NFS root dev?

I looked into this a year and a half ago and got to the conclusion that
ppp can't operate without the pppd userspace program. So I did a small
RAM disk that starts ppp and then use chroot to get to the server root.

This works but running everything over a serial line is slow to start.
Once things has been cached it's works quite good but you really want to
avoid rebooting :)




Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
