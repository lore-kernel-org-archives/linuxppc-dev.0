Message-ID: <3B7D78D5.EB19D6E9@mvista.com>
Date: Fri, 17 Aug 2001 16:04:37 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: "Petersen, David (MED, GEMS-IT)" <David.Petersen@med.ge.com>
Cc: linuxppc emb3dd3d list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: HZ to MHZ, 2.4.2 kernel
References: <B1243F436404D511A5CF009027E705DA0261F7B0@USWAUMSX09MEDGE>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Petersen, David (MED, GEMS-IT)" wrote:
>
> Look at the board information structure you are passing to linux. hh2.0
> is expecting the cpu clock in HZ.

All of this is "self contained" between the zImage bootloader and
Linux itself.  If you have something that boots a kernel directly, you
have to track these changes and make them to your bootloader.

FYI, there are some major changes coming soon where the 8xx and 8260
will start to use bi_recs like all of the other PowerPCs.  That's really
going to mess you up if you aren't booting a zImage.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
