Message-ID: <000a01bf34db$79773180$6401a8c0@everyone>
From: "Neil Blackwood" <nb@terrafix.co.uk>
To: <sorin@nitechinc.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <99111909331400.01435@splash.nitechinc.com>
Subject: Re: IDE on MBX board
Date: Mon, 22 Nov 1999 11:19:41 -0000
MIME-Version: 1.0
Content-Type: text/plain;charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sorin,

Set the following during configuration

CONFIG_PCI
CONFIG_BLK_DEV_IDE
CONFIG_BLK_DEV_IDEDISK
CONFIG_BLK_DEV_IDEPCI
CONFIG_BLK_DEV_SL82C105

I have used this with MBX821 . It at least seems to see the disk during
boot.
I haven't tried partitioning it yet. It only seems to work on 2.2.5. Every
kernel later seems broken

                Neil Blackwood

----- Original Message -----
From: Sorin Balea <sorin@nitechinc.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Sent: 19 November 1999 14:31
Subject: IDE on MBX board


>
> Hello all
>
> I've noticed that the MBX board has an IDE port. Has anyone been able to
> use it, let's say with a hard disk? Any tips regarding this problem?
>
> Regards
>
> Sorin
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
