Message-ID: <0c8201c1005d$39b5aa50$3877b5d3@dolbae>
From: "SangTae Ha" <stha@postech.edu>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <000701c1001f$7d475ea0$9696143e@jocke>
Subject: Re: mpc860 with dual ethernets
Date: Fri, 29 Jun 2001 14:34:52 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


What kind of board are you using? The enet.c and fec.c are enough to handle all possible SCC configurations.
Do you want to SCC1 and SCC2 or SCC1 and FEC(Fast Ethernet Controller)? It's not difficult to use all SCCs as you intended. I have some patches which can be a good reference to do it. Plase contact to me personally.

Redgards,

SangTae Ha




----- Original Message -----
From: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, June 29, 2001 7:12 AM
Subject: mpc860 with dual ethernets


>
> Hi all
>
> I need 2 Ethernet network i/f's(SCC1 and SCC2). Looking into
> enet.c is seems that this driver can only support one Ethernet SCC
> at a time. Is there a version of enet.c that can support both
> SCC1 and SCC2 simultaneously?
>
>     Joakim
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
