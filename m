Message-ID: <3F0DC18F.10106@earthlink.net>
Date: Thu, 10 Jul 2003 12:42:07 -0700
From: Dean Matsen <deanmatsen@earthlink.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Err in config script in 2.4.22-pre4 re: LXT970 and LXT971 chips
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I originally posted this on ppclinux-embedded, but webmaster as
MontaVista suggested
I post it here instead:

I noticed that in the file arch/ppc/8xx_io/Config.in in
the 2.4.22-pre4 (devel) kernel

CONFIG_FEC_LXT970 is listed twice, whereas I think
the second instance should be for the 971/972.

Originally was:

bool 'Support AMD79C874 PHY' CONFIG_FEC_AM79C874
bool 'Support LXT970 PHY' CONFIG_FEC_LXT970
bool 'Support QS6612 PHY' CONFIG_FEC_QS6612
bool 'Support LXT970 PHY' CONFIG_FEC_LXT970
bool 'Support DP83843 PHY' CONFIG_FEC_DP83843

I changed my version to say:

bool 'Support AMD79C874 PHY' CONFIG_FEC_AM79C874
bool 'Support LXT970 PHY' CONFIG_FEC_LXT970
bool 'Support QS6612 PHY' CONFIG_FEC_QS6612
bool 'Support LXT971/972 PHY' CONFIG_FEC_LXT971
bool 'Support DP83843 PHY' CONFIG_FEC_DP83843

Otherwise, you can't use a 971/972 chip.  This is obviously
just a cut-and-paste error.

Thanks
Dean


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
