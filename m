Message-Id: <200009222037.WAA00829@piglet.grunz.lu>
Date: Fri, 22 Sep 2000 22:37:55 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: Re; 2.4.0-test9 on B&W G3 
To: benh@mipsys.com
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20000922164705.32547@mail.mipsys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ben,

On  22 Sep, this message from Benjamin Herrenschmidt echoed through cyberspace:
> This changeset revives Geert PCI code, adds Samuel fix (indeed the
> correct fix), and
> add some more IDE fix for PCI-IDE controllers like the CMD646.

The pci_enable_device() in your changeset is not enough, unfortunately.
My Promise Ultra66 (which others, including Andre Hedrick also use)
doesn't identify as an IDE storage controller:

[mlan@piglet ~]$ lspci
00:0b.0 Host bridge: Apple Computer Inc. Bandit PowerPC host bridge (rev 03)
00:0d.0 Unknown mass storage controller: Promise Technology, Inc. 20262 (rev 01)

Would it be possible to select on mass storage in general? If that is an
'official' classification, that is...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
