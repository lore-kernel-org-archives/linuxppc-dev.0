From: Christophe.LINDHEIMER@fr.thalesgroup.com
Message-ID: <66CE949D18BCB249ABE8D9AF48C4F1CE777746@helios.gnv.tcc.thomson-csf.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Problem with msgget that returns ENOSYS.
Date: Fri, 3 Oct 2003 13:15:50 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi.

I try to execute this line :
	msgget(IPC_PRIVATE, IPC_CREAT);

It return -1 and errno == 38 == ENOSYS.

Kernel is 2.4.4 on a 860 board.

The same soft works fine on a linux running on I386.

Is there something special to configure in the kernel to make this work ?

Thanks

Regards

Chris


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
