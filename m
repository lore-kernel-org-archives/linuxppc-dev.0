From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: broken startup for scsi in 2.4.12 rsync'd this morning
Date: Sat, 13 Oct 2001 21:51:17 +0200
Message-Id: <20011013195117.29022@smtp.wanadoo.fr>
In-Reply-To: <20011013174028.CRXJ4990.tomts6-srv.bellnexxia.net@there>
References: <20011013174028.CRXJ4990.tomts6-srv.bellnexxia.net@there>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I just worked through things with Justin on how to work around an issue in
>the aic7xxx driver and all worked with your 2.4.11 rsynced yesterday
>sometime.
>
>Today (this morning) I rsynced and got your 2.4.12 kernel.
>
>I can not longer get past the initialization of the adaptec card (with or
>without Justin's extra kernel parameters).  After it accesses the adaptec
>card, it simply does a kernel panic.
>
>I compared dmesg output and both at using Justin's 6.2.1 version of the
>aic7xxx driver.
>
>Do you know of any other changes from your 2.4.12 kernel from your 2.4.11
>kernel that might impact use of an adaptec pic scsi card?
>
>I did try rebuilding after an "make mrproper" just to make sure and the
>same problems happened.  I have no trouble booting your 2.4.11 kernel with
>Justin's aic7xxx kernel options.
>
>Any ideas here on how I track this one down would be greatly appreciated.

I've neem myself experiencing various kernel lockups at boot with SCSI
enabled & aic7xxx. In fact, I had some problems with .11 too with a
disk not reponding on my dual G4.

I don't know what's up, but I'd apreciate if you could send me the
panic infos so I can start tracing it.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
