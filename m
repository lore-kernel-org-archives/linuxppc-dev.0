Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: broken startup for scsi in 2.4.12 rsync'd this morning
Date: Sat, 13 Oct 2001 15:16:26 -0400
Cc: linuxppc-dev@lists.linuxppc.org
References: <20011008014159.MXEV19401.tomts15-srv.bellnexxia.net@there> <20011008085545.7838@smtp.wanadoo.fr> <20011013174028.CRXJ4990.tomts6-srv.bellnexxia.net@there>
In-Reply-To: <20011013174028.CRXJ4990.tomts6-srv.bellnexxia.net@there>
MIME-Version: 1.0
Message-Id: <20011013191405.TNCB12483.tomts13-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

In case this helps.  Here is the error message:

scsi0:A:1: ahc_intr-referenced scb not valid during seqint 0x71 scb(0)

This was copied by hand before the kernel panic timeout of 180 seconds was
done.

Anyone with any ideas?

Thanks,

Kevin


On October 13, 2001 01:42, Kevin B. Hendricks wrote:
> Hi Ben,
>
> I just worked through things with Justin on how to work around an issue
> in the aic7xxx driver and all worked with your 2.4.11 rsynced yesterday
> sometime.
>
> Today (this morning) I rsynced and got your 2.4.12 kernel.
>
> I can not longer get past the initialization of the adaptec card (with
> or without Justin's extra kernel parameters).  After it accesses the
> adaptec card, it simply does a kernel panic.
>
> I compared dmesg output and both at using Justin's 6.2.1 version of the
> aic7xxx driver.
>
> Do you know of any other changes from your 2.4.12 kernel from your
> 2.4.11 kernel that might impact use of an adaptec pic scsi card?
>
> I did try rebuilding after an "make mrproper" just to make sure and the
> same problems happened.  I have no trouble booting your 2.4.11 kernel
> with Justin's aic7xxx kernel options.
>
> Any ideas here on how I track this one down would be greatly
> appreciated.
>
> Thanks,
>
> Kevin
>
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
