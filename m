Date: Wed, 3 Mar 2004 17:09:08 +0100 (CET)
From: Jaap-Jan Boor <jjboor@aimsys.nl>
To: linuxppc-embedded@lists.linuxppc.org
Subject: early return set_multicast
Message-ID: <Pine.LNX.4.44.0403031706440.10579-100000@linpc003.aimsys.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

does somebody know why there is an early return;
statement in the set_multicast_list() function
of 8260_io/fcc_enet.c (or cpm2_io/fcc_enet.c)?

----------------
static void
set_multicast_list(struct net_device *dev)
{
        struct  fcc_enet_private *cep;
        struct  dev_mc_list *dmi;
        u_char  *mcptr, *tdptr;
        volatile fcc_enet_t *ep;
        int     i, j;

        cep = (struct fcc_enet_private *)dev->priv;

return;
        /* Get pointer to FCC area in parameter RAM.
        */
        ep = (fcc_enet_t *)dev->base_addr;

        if (dev->flags&IFF_PROMISC) {
        ...
--------------

thanks,

Jaap-Jan

--
J.G.J. Boor			  Anton Philipsweg 1
Software Engineer		  1223 KZ Hilversum
AimSys bv              		  tel. +31 35 689 1941
Postbus 2194, 1200 CD Hilversum   mailto:jjboor@aimsys.nl


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
