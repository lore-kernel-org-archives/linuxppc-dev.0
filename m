Message-ID: <B0CD235912AED411B69800D0B7C9F60F1DF87A@mail>
From: "Francis Yu <francisy@luxn.com>" <francisy@luxn.com>
To: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Kernel not returning from M8xx_cpm_reset
Date: Thu, 21 Nov 2002 11:35:45 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,
I guessed I have made the mistake of changing the KERNELBASE to 0x00000000.
After reading some of the emails on the subject, I changed back to
0xC0000000, and Voila! I start to see a whole bunch of kernel messages being
dump on me. I am very excited at this point. I have not analyzed the
messages yet, but I just want to put out this notice so that you can ignore
my previous email. Thanks.
Francis

-----Original Message-----
From: Francis Yu <francisy@luxn.com> [mailto:francisy@luxn.com]
Sent: Wednesday, November 20, 2002 6:03 PM
To: 'linuxppc-embedded@lists.linuxppc.org'
Subject: Kernel not returning from M8xx_cpm_reset


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
