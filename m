Return-Path: <darenh@4bridgeworks.com>
Received: from ntserver4.diluk.co.uk (mailhost.digitalinterfacesltd.com
	[62.69.87.37]) by ozlabs.org (Postfix) with ESMTP id F30762BDA0
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2004 00:36:35 +1000 (EST)
Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD4502941E6@NTSERVER4>
From: linuxppc <linuxppc@4bridgeworks.com>
To: Linux PPC Dev <linuxppc-dev@ozlabs.org>
Date: Thu, 21 Oct 2004 15:20:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Problem with PPC 440 GX Transmit Path
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have found a problem with the driver for the PPC440GX (ibm_emac), while
reading from the PPC (OCOTEA) BOX doesn't always transmit the last packet, I
have managed to get it to continue by pinging it or from it, or if the root
filesystem is mounted as nfs (I am assuming communications using nfs use a
keepalive test or equivalent). I have also found that by turning on the
debug options in ibm_emac_core.c (PKT_DEBUG) fixes the problem!! I have
removed all but one of the debug messages and as long as they are in the tx
functions (not the rx functions) I have no problems. Any help or guidance
will be appreciated, for now I am going to try and implement gdb.....

Daren
