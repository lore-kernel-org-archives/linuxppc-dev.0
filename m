Message-ID: <903E17B6FF22A24C96B4E28C2C0214D70146BE08@sr-bng-exc01.int.tsbu.net>
From: "Hegde, Ashok" <Ashok.Hegde@fci.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: SMP support problem with NFS mounting
Date: Tue, 30 Dec 2003 16:48:02 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


	Hi All,

		There is a problem with  supporting NFS mounting in
SMP(Symmetric MultiProcessor) mode for MPC 7447 processor(with controller MV
64360) based PMC board(We tried with Kernel.org-2.4.20  and
MontaVista-2.4.18 flavours). It will hang after giving message "Initializing
random number generator... done."

	  { It works fine Without NFS support and Single CPU with NFS }

	 What I need to look into?????



	Thanks,
	Ashok


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
