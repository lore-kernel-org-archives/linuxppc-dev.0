Message-ID: <3F0B87B9.2030209@earthlink.net>
Date: Tue, 08 Jul 2003 20:10:49 -0700
From: Dean Matsen <deanmatsen@earthlink.net>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Err in config script in 2.4.22-pre3 re: LXT970 and LXT971 chips
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format="flowed"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I noticed that in the file arch/ppc/8xx_io/Config.in in
the 2.4.22-pre3 kernel (the devel)

CONFIG_FEC_LXT970 is listed twice, whereas I think
the second instance should be for the 971/972.

My update was:

      bool 'Support AMD79C874 PHY' CONFIG_FEC_AM79C874
      bool 'Support LXT970 PHY' CONFIG_FEC_LXT970
      bool 'Support QS6612 PHY' CONFIG_FEC_QS6612
      bool 'Support LXT971/972 PHY' CONFIG_FEC_LXT971
      bool 'Support DP83843 PHY' CONFIG_FEC_DP83843

Otherwise, you can't use a 971/972 chip

On the other hand, I like seeing these as configuration
options instead of having to hack the fec.c file every
time! :)

Thanks
Dean


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
