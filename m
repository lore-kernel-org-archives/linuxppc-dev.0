From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <66CE949D18BCB249ABE8D9AF48C4F1CE77770D@helios.gnv.tcc.thomson-csf.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Question about ramdisk.
Date: Mon, 29 Sep 2003 16:07:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I am using where linux is running in flash.
I would like to use a ramdisk to develop my application.
So I make mount -t ramdisk /dev/rd/0 /rdisk to get my ramdisk.

The application is developed on my host computer and the only link between
the board and the host is my Bdi2000.

So I would like to copy my cross compiled application into the ramdisk on my
target.

Is there a way to do that ?

I guess that I need to know the @ of the ramdisk ?
How can I get it ?

Thanks

Regards

Chris


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
