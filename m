Date: 5 Aug 2002 04:30:39 -0000
Message-ID: <20020805043039.4380.qmail@webmail6.rediffmail.com>
MIME-Version: 1.0
From: "Narendra  " <narengh@rediffmail.com>
Reply-To: "Narendra  " <narengh@rediffmail.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: CS_BAD_VCC Error during Card Configaration.
Content-type: text/plain;
	format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi.

I am involved in porting WLAN driver to Embedded Planet RPX-LITE
board.

I am using HHL - 2,4,2 and Pcmcia-cs (3.1.24). When i insert
D-Link DWL 350 prism2 card (intersil) my driver is invoked by
cardmgr.

But as i found through debug message, socket is configured for
5volts and the CIS read from my card wants 3.3V. So my Config()
routine is failing since there is a mismatch in configured Vcc and
Requested Vcc. and Kernel is crashing.

Where i need to do modification to configure EP socket for 3.3v?

Should i need to make any modification in m8xx_pcmcia.c?

I didn`t come across this problem when i tested my driver in
Compaq Armada notebook.

I am struck at this point. All inputs are welcome.

Thanks in advance,

Regards,
Naren


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
