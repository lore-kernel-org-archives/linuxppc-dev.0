Date: Fri, 8 Oct 1999 10:01:46 +0200 (MET DST)
From: Nick Hibma <nick.hibma@jrc.it>
Reply-To: Nick Hibma <nick.hibma@jrc.it>
To: jingai <jingai@earthlink.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>,
        linuxppc-user <linuxppc-user@lists.linuxppc.org>,
        linux-usb <linux-usb@suse.com>
Subject: Re: [linux-usb] Continuing USB Problems
In-Reply-To: <199910080148.SAA15697@snipe.prod.itd.earthlink.net>
Message-ID: <Pine.GS4.4.10.9910080959580.3456-100000@elect8>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


 > UMAX S900 (PowerMac clone), Entrega 4-port USB card (two root hubs, I 
 > believe), Contour Designs Unimouse, and a MacAlly iKey keyboard.

Nope, one root hub (OHCI) and a Texas Instruments behind on 1 of the
root ports. I haven't checked yet whether the other root port could be
used as well.


 > usb-ohci: 2 root hub ports found
 > ohci_connect_change on port 0
 > USB new device connect, assigned device number 1
 > ohci_control_msg: timed out on pipe 80000080 cmd 80 6 100 0 8

It looks like a problem in the hub driver.

Nick
-- 
ISIS/STA, T.P.270, Joint Research Centre, 21020 Ispra, Italy


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
