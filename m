From: Benjamin Herrenschmidt <bh40@calva.net>
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Need testers with MESH SCSI
Date: Fri, 22 Dec 2000 00:06:38 +0100
Message-Id: <19341115163822.14429@192.168.1.2>
In-Reply-To: 
 <Pine.LNX.4.10.10012212257070.22462-100000@opal.biophys.uni-duesseldorf.de>
References: 
 <Pine.LNX.4.10.10012212257070.22462-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Neither does it change anything for me (Lombard, SCSI Zip and Quantum
>VP32210). I've not tried to force any bus resets or something weird
>though.

Well, I didn't change mesh_reset(), only mesh_init(). Since it seem that
it doesn't break working configs but actually fix some non working ones,
I'll push it one of these days.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
