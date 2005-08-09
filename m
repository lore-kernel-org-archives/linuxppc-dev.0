Return-Path: <Peter.Schaefer-Hutter@tfk-racoms.com>
Received: from rcprx1.tfk-racoms.com (rcprx1.tfk-racoms.com [195.245.55.49])
	by ozlabs.org (Postfix) with SMTP id 9754E68011
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 02:42:09 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 9 Aug 2005 18:42:46 +0200
Message-ID: <8E342283C2100540AAC5D10309705477749D97@rcexc.racoms.loc>
From: "Schaefer-Hutter, Peter" <Peter.Schaefer-Hutter@tfk-racoms.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: fs_enet on MPC885ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there,

Are there any boot options needed to enable the fs_enet driver
on the MPC885ADS? I replaced CONFIG_DUET with CONFIG_MPC885ADS
in drivers/net/fs_enet/mac-fec.c, but only got

  fs_enet.c:v0.1 (May 6, 2005)
  NET: Registered protocol family 2
  IP route cache hash table entries: 128 (order: -3, 512 bytes)
  TCP established hash table entries: 512 (order: 0, 4096 bytes)
  TCP bind hash table entries: 512 (order: -1, 2048 bytes)
  TCP: Hash tables configured (established 512 bind 512)
  TCP reno registered
  TCP bic registered
  NET: Registered protocol family 1
  NET: Registered protocol family 17
  IP-Config: Device `eth0' not found.

Reason i'm asking is that the current cpm_uart driver doesn't work
with the SCC3 ethernet driver included in the MPC885 board support
(as soon as ethernet is initialized, console output stops).

Best regards,

 Peter
