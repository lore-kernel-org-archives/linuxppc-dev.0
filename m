From: Christian =?iso-8859-1?q?Tr=F6ster?= <please.see.sig@gmx.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: what is the status of devfs?
Date: Fri, 9 Jul 2004 13:17:45 +0200
References: <Pine.LNX.4.60.0407081035280.32470@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.60.0407081035280.32470@localhost.localdomain>
MIME-Version: 1.0
Message-Id: <200407091317.46128.please.see.sig@gmx.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Robert!

Am Donnerstag, 8. Juli 2004 16:38 schrieb Robert P. J. Day:
>    probably should send this to the main kernel list, but in playing
> around, i noticed that DEVFS_FS is labelled as both OBSOLETE and NEW,
> but in the Kconfig file, it depends on EXPERIMENTAL.
>
>    it seems a bit inconsistent for anything to be simultaneously
> EXPERIMENTAL, NEW and OBSOLETE, no?
I assume you are talking about 2.6.x :)
See Documentation/Changes line 115:
"DevFS has been obsoleted in favour of udev
(http://www.kernel.org/pub/linux/utils/kernel/hotplug/)"

Bye, Christian

--
| c dot troester at gmx dot de | PGP-Id: FA006C74 |

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
