From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mlan@cpu.lu>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Re; 2.4.0-test9 on B&W G3 
Date: Fri, 22 Sep 2000 23:37:53 +0200
Message-Id: <19340817150937.10283@192.168.1.10>
In-Reply-To: <200009222037.WAA00829@piglet.grunz.lu>
References: <200009222037.WAA00829@piglet.grunz.lu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The pci_enable_device() in your changeset is not enough, unfortunately.
>My Promise Ultra66 (which others, including Andre Hedrick also use)
>doesn't identify as an IDE storage controller:
>
>[mlan@piglet ~]$ lspci
>00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
>00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20262
>(rev 01)
>
>Would it be possible to select on mass storage in general? If that is an
>'official' classification, that is...

Well, we could. That is supposed to remain a temporary hack until we find
a better way to tell the IDE driver to stop avoiding disabled cards if
told so by the arch.

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
