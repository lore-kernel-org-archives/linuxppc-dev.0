Message-ID: <0d4f01c10079$12cb22f0$3877b5d3@dolbae>
From: "SangTae Ha" <stha@postech.edu>
To: "Dan Malek" <dan@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <000701c1001f$7d475ea0$9696143e@jocke> <3B3C3E29.F3092A80@mvista.com>
Subject: Re: mpc860 with dual ethernets
Date: Fri, 29 Jun 2001 17:54:14 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


You support SCC1 and SCC2 only inside the enet.c file? . I had made a file like enet2.c enet3.c something like that. I thought that a SCCx could be one ethernet or other device as well. Could you let me know if you have any comments about it?

Regards,

SangTae Ha

----- Original Message -----
From: "Dan Malek" <dan@mvista.com>
To: "Joakim Tjernlund" <Joakim.Tjernlund@lumentis.se>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, June 29, 2001 5:36 PM
Subject: Re: mpc860 with dual ethernets


>
> Joakim Tjernlund wrote:
>
> > ... Is there a version of enet.c that can support both
> > SCC1 and SCC2 simultaneously?
>
> Yes, I have the patches.  I'm travelling and will post them in
> a day or so.
>
>
> -- Dan
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
