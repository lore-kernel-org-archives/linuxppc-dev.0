From: "Michael Fischer" <fischi@epygi.de>
To: "Elan Feingold" <elan@nxnetworks.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: MPC8255 vs MPC8260?
Date: Fri, 10 Aug 2001 10:57:41 +0200
Message-ID: <OEEHJMIIDJHHMFGGDNGDKEPFCEAA.fischi@epygi.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <NDBBLJKOJGKDOFBHNPGEKEGMCEAA.elan@nxnetworks.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> We're going to be using an MPC8255 processor, and I know there are a few
> differences between that CPU and the 8260 (e.g. less clock speed,
> less SCCs,
> etc.).
We also have custom HW with an MPC8255. PPC Linux 2.4.3 and 2.4.8 runs
perfectly. No changes apart from the things you need to do for custom HW
anyway (IO pinning etc.) were necessary. We also run PPCBoot on the board.


Greetings Michael


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
