From: Benjamin Herrenschmidt <bh40@calva.net>
To: FASSINO Jean-Philippe <jeanphilippe.fassino@rd.francetelecom.fr>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Promiscuous mode & Link change
Date: Wed, 6 Dec 2000 12:39:55 +0100
Message-Id: <19341031051139.14747@192.168.1.2>
In-Reply-To: <3A2E1430.84036697@rd.francetelecom.fr>
References: <3A2E1430.84036697@rd.francetelecom.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>When using network card in promiscious mode and when link
>change (down or speed),  the promiscious mode is reset and
>card not stay in promiscious mode.
>
>Is it normal, or is it a feature not managed by Linux ?

This depends on the network chip driver. Which card have you
seen this with ?

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
