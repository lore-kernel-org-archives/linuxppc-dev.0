Message-ID: <38EAAD5C.6F1040C@embeddededge.com>
Date: Tue, 04 Apr 2000 23:05:00 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: dony <dony.he@huawei.com.cn>
CC: linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MPC860 CPM HDLC device driver...
References: <38EAB725.7C5F0023@huawei.com.cn>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


dony wrote:

>       Since mpc8xx-2.2.13 doesn't support CPM HDLC device driver, Will
> it be supported in the coming 2.3.x packages?


I don't have anything generically available to check into the sources.
All I have seen are custom drivers with a specific application.

You can add a couple of bits and a few lines of initialization code
to the SCC uart driver and make them run HDLC.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
